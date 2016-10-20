//
//  TableViewCells.swift
//  Timelines
//
//  Created by Princess Sampson on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class FreeCell: UITableViewCell {
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
    
}

class EventCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var startTime: UILabel!
    @IBOutlet var endTime: UILabel!
}

class FriendCell: UITableViewCell {
    @IBOutlet var username: UILabel!
}

class PendingRequestCell: UITableViewCell {
    @IBOutlet var username: UILabel!
    var requestID: Int?
}

class PendingContactCell: UITableViewCell {
    @IBOutlet var message: UILabel!
}
