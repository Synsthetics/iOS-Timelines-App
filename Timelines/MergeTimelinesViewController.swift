//
//  MergeTimelinesViewController.swift
//  Timelines
//
//  Created by Princess Sampson on 10/17/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class MergeTimelinesViewController: UIViewController {
    @IBOutlet var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        UserStore.contacts.append((username: "sampson", selected: false))
        UserStore.contacts.append((username: "sampson2", selected: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserStore.mainUser else {
            return
        }
        
        let request = ContactsRequest(username: user.username)
        
        API.contacts(body: request) { contactsResponse in
            guard let contacts = contactsResponse.contacts as? [(username: String, selected: Bool)] else {
                print(contactsResponse.errorMessage)
                return
            }
            
            UserStore.contacts = contacts
        }
        
        friendsTableView.reloadData()
    }
    
    @IBAction func attemptContactRequest(_ sender: UIButton) {
        guard let user = UserStore.mainUser else {
            return
        }
        
        let alert = AlertView.createAlertWithTextField(title: "Add contact", message: "Input username of contact", actionTitle: "Send") { receiver in
            let request = FriendRequest(sender: user.username, reciever: receiver)
            
            API.requestFriend(body: request) { message in
                OperationQueue.main.addOperation {
                    let messageAlert = AlertView.createAlert(title: "", message: message, actionTitle: "OK")
                    
                    self.present(messageAlert, animated: true, completion: nil)
                }
            }
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func mergeTimelines(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            self.tabBarController?.selectedIndex = 0
        }
    }
    
}

extension MergeTimelinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserStore.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendTuple = UserStore.contacts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        cell.accessoryType = .none
        cell.username.text = friendTuple.username
        
        if friendTuple.selected {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
}

extension MergeTimelinesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var friend = UserStore.contacts[indexPath.row]
        friend.selected = !friend.selected
        
        UserStore.contacts.remove(at: indexPath.row)
        UserStore.contacts.insert(friend, at: indexPath.row)
        
        tableView.reloadData()
    }
}
