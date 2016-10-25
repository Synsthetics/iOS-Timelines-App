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
        appViewProxy.backgroundColor = .timelines_backgroundLight
    }
    
    private static func navigationBar() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.barTintColor = .white
        navigationBarProxy.tintColor = .timelines_lightBlue
    }
    
    private static func tabBar() {
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barTintColor = .timelines_tabBarBackground
        tabBarProxy.tintColor = .timelines_tabBarTintColor
        
        let tabBarItemProxy = UITabBarItem.appearance()
        tabBarItemProxy.badgeColor = .red
    }
    
    private static func tableView() {
        let tableViewProxy = UITableView.appearance()
        tableViewProxy.backgroundColor = .timelines_backgroundLight
        
        let tableViewCellProxy = UITableViewCell.appearance()
        tableViewCellProxy.backgroundColor = .timelines_backgroundLight
    }
    
    private static func segmentedControl() {
        let segmentedControlProxy = UISegmentedControl.appearance()
        segmentedControlProxy.tintColor = .timelines_lightBlue
    }
    
    private static func buttons() {
        let buttonProxy = UIButton.appearance()
        buttonProxy.backgroundColor = .timelines_lightBlue
        buttonProxy.tintColor = .timelines_buttonTint
    }
}

class AppView: UIView {
    
}
