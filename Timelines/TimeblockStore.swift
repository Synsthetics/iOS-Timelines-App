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
    
    static func insert(timeblock: Timeblock, at index: Int) -> Bool {
        TimeblockStore.timeblocks.remove(at: index)
        TimeblockStore.timeblocks.insert(timeblock, at: index)
        
        if TimeblockStore.timeblocks.contains(timeblock) {
            return true
        }
        return false
    }

}
