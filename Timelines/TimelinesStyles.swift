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
        buttons()
    }
    
    private static func appView() {
        let appViewProxy = AppView.appearance()
        appViewProxy.backgroundColor = UIColor.timelines_background
    }
    
    private static func navigationBar() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.layer.borderWidth = 0.0
        navigationBarProxy.backItem?.title = ""
    }
    
    private static func tabBar() {
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barTintColor = UIColor.timelines_tabBarBackground
        tabBarProxy.tintColor = UIColor.timelines_tabBarItemColor
        tabBarProxy.barStyle = .default
        tabBarProxy.layer.borderWidth = 0.0
        
        let tabBarItemProxy = UITabBarItem.appearance()
        tabBarItemProxy.badgeColor = .red
    }
    
    private static func tableView() {
        let tableViewProxy = UITableView.appearance()
        tableViewProxy.backgroundColor = UIColor.timelines_background
    }
    
    private static func buttons() {
        let buttonProxy = UIButton.appearance()
        buttonProxy.backgroundColor = UIColor.timelines_buttonColor
        buttonProxy.tintColor = UIColor.timelines_buttonTint
    }
    
}

class AppView: UIView {
    
}
