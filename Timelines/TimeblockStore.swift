//
//  TimeblockStore.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class TimeblockStore {
    
    static var timeblocks: [Timeblock] = [TimeblockStore.emptyWeek]
    static var emptyWeek: Timeblock {
        let now = Date()
        let endOfWeek = now.addingTimeInterval(60 * 60 * 24 * 7)
        return Timeblock(start: now, end: endOfWeek)
    }
    
    static func insert(timeblock: Timeblock, at index: Int) {
        TimeblockStore.timeblocks.remove(at: index)
        TimeblockStore.timeblocks.insert(timeblock, at: index)
    }

}
