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
        appViewProxy.backgroundColor = UIColor.timelines_backgroundLight
    }

    private static func navigationBar() {
        let navigationBarProxy = UINavigationBar.appearance()
        navigationBarProxy.barTintColor = UIColor.timelines_tabBarBackground
        navigationBarProxy.tintColor = UIColor.timelines_tabBarTintColor
    }

    private static func tabBar() {
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barTintColor = UIColor.timelines_tabBarBackground
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

    private static func buttons() {
        let buttonProxy = UIButton.appearance()
        buttonProxy.backgroundColor = UIColor.timelines_buttonColor
        buttonProxy.tintColor = UIColor.timelines_buttonTint
    }
}

class AppView: UIView {
    
}
