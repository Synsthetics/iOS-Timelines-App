//
//  TimeblockStore.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/13/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

class TimeblockStore {
    
    static var timeblocks: [Timeblock] = []
    
    static func insert(timeblock: Timeblock, at index: Int) {
        TimeblockStore.timeblocks.remove(at: index)
        TimeblockStore.timeblocks.insert(timeblock, at: index)
    }

}
