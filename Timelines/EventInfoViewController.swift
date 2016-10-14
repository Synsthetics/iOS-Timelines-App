//
//  EventInfoViewController.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {
    
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventOwnerLabel: UILabel!
    @IBOutlet var eventStartLabel: UILabel!
    @IBOutlet var eventEndLabel: UILabel!
    @IBOutlet var eventDurationLabel: UILabel!
    @IBOutlet var eventDetailsTextView: UITextView!
    @IBOutlet var eventAttendeesTableView: UITableView!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventNameLabel.text = self.event!.name
        self.eventOwnerLabel.text = self.event!.owner.username
        let times = DateTools.localTimes(for: self.event!)
        self.eventStartLabel.text = times.start
        self.eventEndLabel.text = times.end
        self.eventDurationLabel.text = "\(Int(self.event!.duration / 60.0))"
        self.eventDetailsTextView.text = self.event!.details
    }
    
}

extension EventInfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.event!.attendees!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
