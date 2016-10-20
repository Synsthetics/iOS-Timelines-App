//
//  EventsViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, LoginViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var weeklyTimeblocks: [Timeblock] {
        let now: Date = {
            return Date(timeIntervalSinceReferenceDate: floor((Date().timeIntervalSinceReferenceDate / 60.0)) * 60)
        }()
        let endOfWeek = now.addingTimeInterval(60 * 60 * 24 * 7)
        
        var timeblocks: [Timeblock] = TimeblockStore.timeblocks.flatMap {
            let timeblock = $0
            
            if timeblock.end < now {
                return nil
            }
            
            if timeblock.start < now {
                if let event = timeblock as? Event {
                    return event
                } else {
                    return Timeblock(start: now, end: timeblock.end)
                }
            }
            
            if timeblock.start > endOfWeek {
                return nil
            }
            
            return timeblock
        }
        
        let firstTimeblock = timeblocks.first
        let lastTimeblock = timeblocks.last
        
        guard !timeblocks.isEmpty else {
            return [Timeblock(start: now, end: endOfWeek)]
        }
        
        if (firstTimeblock?.start)! > now {
            let newFirstTimeblock = Timeblock(start: now, end: (firstTimeblock?.start)!)
            timeblocks.insert(newFirstTimeblock, at: 0)
        }
        
        if (lastTimeblock?.end)! < endOfWeek {
            let newLastTimeblock = Timeblock(start: (lastTimeblock?.end)!, end: endOfWeek)
            timeblocks.append(newLastTimeblock)
        }
        
        return timeblocks
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard UserStore.mainUser != nil else {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.delegate = self
            present(UINavigationController.init(rootViewController: (loginVC)), animated: false, completion: nil)
            return
        }
        self.getRecentEvents()
    }
    
    private func getRecentEvents() {
        guard UserStore.mainUser != nil else {
            return
        }
        
        let request = MergeTimelinesRequest(usernames: UserStore.selectedContacts)
        
        API.mergeTimelines(body: request) { eventsResponse in
            guard let timeblocks = eventsResponse.timeblocks else {
                return
            }
            
            if !(eventsResponse.timeblocks?.isEmpty)! {
                TimeblockStore.timeblocks = timeblocks
            }
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let _ = tableView.cellForRow(at: indexPath) as? EventCell {
            let eventInfoView = storyBoard.instantiateViewController(withIdentifier: "EventInfoViewController") as! EventInfoViewController
            eventInfoView.event = self.weeklyTimeblocks[indexPath.row] as? Event
            show(eventInfoView, sender: nil)
        } else {
            let newEventView = storyBoard.instantiateViewController(withIdentifier: "NewEventViewController") as! NewEventViewController
            newEventView.timeblock = self.weeklyTimeblocks[indexPath.row]
            newEventView.timeblockIndex = self.weeklyTimeblocks.index(of: self.weeklyTimeblocks[indexPath.row])
            show(newEventView, sender: nil)
        }
    }
    
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weeklyTimeblocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let timeblock = self.weeklyTimeblocks[indexPath.row]
        
        if let event = timeblock as? Event {
            let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
            eventCell.title.text = event.name
            eventCell.startTime.text = event.start.description
            eventCell.endTime.text = event.end.description
            cell = eventCell
        } else {
            let freeCell = tableView.dequeueReusableCell(withIdentifier: "FreeCell") as! FreeCell
            freeCell.startTime.text = timeblock.start.description
            freeCell.endTime.text = timeblock.end.description
            cell = freeCell
        }
        
        return cell
    }
    
    func loginViewController(_ vc: LoginViewController, didFinishLogin user: User) {
        UserStore.mainUser = user
        vc.dismiss(animated: true, completion: nil)
        let pendingVC = self.tabBarController?.viewControllers?[2] as! PendingRequestsViewController
        pendingVC.pollForContacts()
    }
    
}
