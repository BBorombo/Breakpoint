//
//  GroupFeedVC.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit
import  Firebase

class GroupFeedVC: UIViewController {

    // Outlets
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var messageTextField: InsertTextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // Variables
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate =  self
        tableView.dataSource = self
        
        sendMessageView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.groupeTitle
        DataService.instance.getEmailsFor(group: group!) { (emails) in
            self.membersLabel.text = emails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.child(group!.key).observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (messages) in
                self.groupMessages = messages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key, sendComplete: { (success) in
                if  success {
                    self.messageTextField.isEnabled = true
                    self.messageTextField.text =  ""
                    self.sendButton.isEnabled = true
                }
            })
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismissDetail()
        //dismiss(animated: true, completion: nil)
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {return UITableViewCell()}
        
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
}
