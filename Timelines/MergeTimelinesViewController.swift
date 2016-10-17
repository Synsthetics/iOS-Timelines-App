//
//  MergeTimelinesViewController.swift
//  Timelines
//
//  Created by Princess Sampson on 10/17/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class MergeTimelinesViewController: ViewController {
    @IBOutlet var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        
        let sampson = User(id: 0, username: "sampson", email: nil)
        let sampson2 = User(id: 69, username: "sampson2", email: nil)
        
        
        UserStore.friends.append((user: sampson, selected: false))
        UserStore.friends.append((user: sampson2, selected: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendsTableView.reloadData()
    }
    
    @IBAction func mergeTimelines(_ sender: UIButton) {
        OperationQueue.main.addOperation {
            self.tabBarController?.selectedIndex = 0
        }
    }
    
}

extension MergeTimelinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserStore.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let friendTuple = UserStore.friends[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as! FriendCell
        cell.accessoryType = .none
        cell.username.text = friendTuple.user.username
        
        if friendTuple.selected {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
}

extension MergeTimelinesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var friend = UserStore.friends[indexPath.row]
        friend.selected = !friend.selected
        
        UserStore.friends.remove(at: indexPath.row)
        UserStore.friends.insert(friend, at: indexPath.row)
        
        tableView.reloadData()
    }
}
