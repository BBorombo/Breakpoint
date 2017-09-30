//
//  CreateGroupVC.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    // Outlets
    @IBOutlet weak var titleTextField: InsertTextField!
    @IBOutlet weak var descriptionTextField: InsertTextField!
    @IBOutlet weak var emailSearchTextField: InsertTextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var groupMemberLable: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // Variables
    var emails = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if emailSearchTextField.text == "" {
            emails = []
            tableView.reloadData()
        }else{
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmails) in
                self.emails = returnedEmails
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        if  titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (returnedIds) in
                print(returnedIds)
                var userIds = returnedIds
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("Groupd could not be created. Please try again")
                    }
                })
            })

        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupVC:UITextFieldDelegate {
    
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        if  chosenUserArray.contains(emails[indexPath.row]){
            cell.configureCell(profileImage: profileImage!, email: emails[indexPath.row], isSelected: true)
        }else{
            cell.configureCell(profileImage: profileImage!, email: emails[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if  !chosenUserArray.contains(cell.emailLabel.text!){
            chosenUserArray.append(cell.emailLabel.text!)
            groupMemberLable.text = chosenUserArray.joined(separator: ", ")
            doneButton.isHidden = false
        }else{
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if  chosenUserArray.count >= 1 {
                groupMemberLable.text = chosenUserArray.joined(separator: ", ")
            }else{
                groupMemberLable.text = "Add people to your group"
                doneButton.isHidden = true
            }
        }
        
    }
}
