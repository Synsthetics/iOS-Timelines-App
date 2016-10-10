//
//  JSONTools.swift
//  Timeline
//
//  Created by Princess Sampson on 10/9/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import Foundation

/// Provides helper methods for going from data to JSON, and from dictionaries to chosen types
struct JSONTools {
    
    /// If provided data can be serialized to JSON, it casts JSON to [String: Any]
    static func dataToDictionary(_ data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
}
