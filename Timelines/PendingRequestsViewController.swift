//
//  PendingRequestsViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class PendingRequestsViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pollForContacts()
    }
    
    func pollForContacts() {
        guard let user = UserStore.mainUser else {
            return
        }
        
        let timer = Timer(timeInterval: 5.0, repeats: true) { _ in
            print("\n\ntimer ran\n\n")
            if UserStore.shouldPoll {
                let request = ContactsRequest(username: user.username)
                
                API.contactRequests(body: request) { contactsResponse in
                    guard let contacts = contactsResponse.contacts else {
                        print(contactsResponse.errorMessage)
                        return
                    }
                    
                    for contact in contacts {
                        UserStore.addPendingRequest(username: contact)
                    }
                }
            }
            OperationQueue.main.addOperation {
                print(self.tabBarController)
                print(self.tabBarController?.tabBarItem)
                self.tabBarItem.badgeColor = UIColor.red
                self.tabBarItem.badgeValue = "\(UserStore.pendingRequests.count)"
            }
        }
        RunLoop.main.add(timer, forMode: .commonModes)
    }
}
