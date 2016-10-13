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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
}

extension EventsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? EventCell {
            print("✅✅✅✅✅✅✅✅")
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let eventInfoView = storyBoard.instantiateViewController(withIdentifier: "EventInfoViewController") as! EventInfoViewController
            eventInfoView.event = TimeblockStore.timeblocks[indexPath.row] as? Event
            show(eventInfoView, sender: nil)
        }
    }
    
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeblockStore.timeblocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let timeblock = TimeblockStore.timeblocks[indexPath.row]
        
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
