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
        appView()
        tabBar()
        navigationBar()
        segmentedControl()
        buttons()
    }
    
    private static func appView() {
        let appViewProxy = AppView.appearance()
        appViewProxy.backgroundColor = UIColor.timelines_backgroundLight
    }
    
    private static func navigationBar() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.barTintColor = UIColor.timelines_tabBarBackground
        navigationBarProxy.tintColor = UIColor.timelines_tabBarTintColor
    }
    
    private static func tabBar() {
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barTintColor = UIColor.white
        tabBarProxy.tintColor = UIColor.timelines_tabBarTintColor
        
        let tabBarItemProxy = UITabBarItem.appearance()
        tabBarItemProxy.badgeColor = .red
    }
    
    private static func tableView() {
        let tableViewProxy = UITableView.appearance()
        tableViewProxy.backgroundColor = UIColor.timelines_backgroundLight
        
        let tableViewCellProxy = UITableViewCell.appearance()
        tableViewCellProxy.backgroundColor = UIColor.timelines_backgroundLight
    }
    
    private static func segmentedControl() {
        let segmentedControlProxy = UISegmentedControl.appearance()
        segmentedControlProxy.tintColor = UIColor.timelines_lightBlue
    }
    
    private static func buttons() {
        let buttonProxy = UIButton.appearance()
        buttonProxy.backgroundColor = UIColor.timelines_lightBlue
        buttonProxy.tintColor = UIColor.timelines_buttonTint
    }
}

class AppView: UIView {
    
}
