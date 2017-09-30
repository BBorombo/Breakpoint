//
//  SecondViewController.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    // Outlets
    @IBOutlet weak var groupTableView: UITableView!
    
    // Variables
    var groupsArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapchot) in
            DataService.instance.getAllGroups { (returnedGroups) in
                self.groupsArray = returnedGroups
                self.groupTableView.reloadData()
            }
        }
    }
}

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell()}
        let group = groupsArray[indexPath.row]
        cell.configureCell(title: group.groupeTitle, description: group.groupeDesc, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {return}
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeedVC)
        //present(groupFeedVC, animated: true, completion: nil)
    }
    
}

