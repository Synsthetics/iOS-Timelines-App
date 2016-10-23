//
//  TimelinesStyles.swift
//  Timelines
//
//  Created by Princess Sampson on 10/23/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

struct TimelinesStyles {
    
    static func apply() {
        tabBar()
    }
    
    private static func navigationBar() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.backItem?.title = ""
    }
    
    private static func tabBar() {
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barTintColor = UIColor.timelines_tabBarBackground
        tabBarProxy.barStyle = .default
        tabBarProxy.layer.borderWidth = 0.0
    }

}
