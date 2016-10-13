//
//  Timeblock.swift
//  Timelines
//
//  Created by Rodney Sampson on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class Timeblock {
    var start: Date
    var end: Date
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
}
