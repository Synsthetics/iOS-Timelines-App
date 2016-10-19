//
//  PendingRequestsViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class PendingRequestsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarItem.badgeValue = "\(UserStore.pendingContacts.count)"
        self.tabBarItem.badgeColor = UIColor.blue
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
                        UserStore.addPendingRequest(username: contact.username)
                    }
                }
            }
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeValue = "\(UserStore.pendingContacts.count)"
            self.tabBarController?.viewControllers?[2].tabBarItem.badgeColor = UIColor.blue
        }
//        RunLoop.main.add(timer, forMode: .commonModes)
    }
}
