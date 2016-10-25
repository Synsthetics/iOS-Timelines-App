//
//  TableViewCells.swift
//  Timelines
//
//  Created by Princess Sampson on 10/12/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

class TimeblockCell: UITableViewCell {
    @IBOutlet var date: UILabel!
    @IBOutlet var startAndEndTime: UILabel!
}

class UserEventCell: TimeblockCell {
    @IBOutlet var title: UILabel!
}

class FriendEventCell: TimeblockCell {
    @IBOutlet var username: UILabel!
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
