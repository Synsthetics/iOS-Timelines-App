//
//  PendingRequestsViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

enum tableControlSelected: Int {
    case received = 0
    case sent = 1
}

class PendingRequestsViewController: UIViewController {
    @IBOutlet var tableControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableControl.addTarget(tableView, action: #selector(UITableView.reloadData), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let user = UserStore.mainUser else {
            return
        }
        
        let request = ContactsRequest(username: user.username)
        
        API.pendingContacts(body: request) { pendingContactsResponse in
            
            guard let pendingContact = pendingContactsResponse.pendingContacts else {
                print(pendingContactsResponse.errorMessage)
                return
            }
            
            for username in pendingContact {
                UserStore.addPendingContact(username: username)
            }
        }
    }
    
    func pollForContacts() {
        guard let user = UserStore.mainUser else {
            return
        }
        
        let timer = Timer(timeInterval: 5.0, repeats: true) { _ in
            print("💜timer ran")
            
            if UserStore.shouldPoll {
                let request = ContactsRequest(username: user.username)
                
                API.contactRequests(body: request) { contactRequestsResponse in
                    guard let contactRequests = contactRequestsResponse.requests else {
                        print(contactRequestsResponse.errorMessage)
                        return
                    }
                    
                    for request in contactRequests {
                        UserStore.addPending(request: request)
                    }
                    OperationQueue.main.addOperation {
                        self.tabBarItem.badgeColor = UIColor.red
                        if UserStore.pendingRequests.isEmpty {
                            self.tabBarItem.badgeValue = nil
                        } else {
                            self.tabBarItem.badgeValue = "\(UserStore.pendingRequests.count)"
                        }
                    }
                }
            }
            
            OperationQueue.main.addOperation {
                self.tabBarItem.badgeColor = UIColor.red
                if UserStore.pendingRequests.isEmpty {
                    self.tabBarItem.badgeValue = nil
                } else {
                    self.tabBarItem.badgeValue = "\(UserStore.pendingRequests.count)"
                }
            }
        }
        
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    @IBAction func acceptRequest(_ sender: UIButton) {
        let cellAndStoreIndex = cellAndPendingRequestStoreIndex(for: sender)
        let request = AcceptOrDenyContactRequest(id: cellAndStoreIndex.cell.requestID!, accepted: true)
        
        confirmOrDenyContact(request: request, storeIndex: cellAndStoreIndex.storeIndex)
    }
    
    @IBAction func denyRequest(_ sender: UIButton) {
        let cellAndStoreIndex = cellAndPendingRequestStoreIndex(for: sender)
        let request = AcceptOrDenyContactRequest(id: cellAndStoreIndex.cell.requestID!, accepted: false)
        
        confirmOrDenyContact(request: request, storeIndex: cellAndStoreIndex.storeIndex)
    }
    
}

extension PendingRequestsViewController {
    
    fileprivate func cellAndPendingRequestStoreIndex(for button: UIButton) -> (cell: PendingRequestCell, storeIndex: Int) {
        let cell = button.superview?.superview?.superview?.superview as! PendingRequestCell
        let cellIndexPath = tableView.indexPath(for: cell)!
        
        return (cell: cell, storeIndex: cellIndexPath.row)
    }
    
    fileprivate func confirmOrDenyContact(request: AcceptOrDenyContactRequest, storeIndex: Int) {
        
        API.acceptOrDenyContact(body: request) { acceptOrDenyContactResponse in
            print("💜\(acceptOrDenyContactResponse)")
            
            OperationQueue.main.addOperation {
                UserStore.pendingRequests.remove(at: storeIndex)
                self.tableView.reloadData()
            }
        }
    }
}


extension PendingRequestsViewController: UITableViewDelegate {
    
}

extension PendingRequestsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableControl.selectedSegmentIndex {
        case tableControlSelected.received.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingRequestCell") as! PendingRequestCell
            let pendingRequest = UserStore.pendingRequests[indexPath.row]
            cell.username.text = pendingRequest.username
            cell.requestID = pendingRequest.requestID
            
            return cell
        case tableControlSelected.sent.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingContactCell") as! PendingContactCell
            let pendingContact = UserStore.pendingContacts[indexPath.row]
            cell.message.text = "You sent a contact request to @\(pendingContact)"
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableControl.selectedSegmentIndex {
        case tableControlSelected.received.rawValue:
            return UserStore.pendingRequests.count
        case tableControlSelected.sent.rawValue:
            return UserStore.pendingContacts.count
        default:
            return 0
        }
        
        
    }
}
