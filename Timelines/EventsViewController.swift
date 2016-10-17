//
//  EventsViewController.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var weeklyTimeblocks: [Timeblock] {
        let now = Date()
        let endOfWeek = now.addingTimeInterval(60 * 60 * 24 * 7)
        
        var timeblocks: [Timeblock] = TimeblockStore.timeblocks.flatMap {
            let timeblock = $0
            
            if timeblock.end < now {
                return nil
            }
            
            if timeblock.start < now {
                return Timeblock(start: now, end: timeblock.end)
            }
            
            if timeblock.start > endOfWeek {
                return nil
            }
            
            if timeblock.end > endOfWeek {
                return Timeblock(start: timeblock.start, end: endOfWeek)
            }
            
            return timeblock
        }
        
        let timeblock = timeblocks.last
        
        if (timeblock?.end)! < endOfWeek {
            let lastTimeblock = Timeblock(start: (timeblock?.end)!, end: endOfWeek)
            timeblocks.append(lastTimeblock)
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
        self.getRecentEvents()
    }
    
    private func getRecentEvents() {
        guard UserStore.mainUser != nil else {
            return
        }
        
        let request = MergeTimelinesRequest(usernames: UserStore.selectedFriends)
        
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
    
}
