//
//  AppDelegate.swift
//  Timelines
//
//  Created by Daniel Kwolek on 10/10/16.
//  Copyright © 2016 Arcore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //        API.register(body: RegisterRequest(email: "tim", username: "tim", password: "tim")) {
        //            authResponse in
        //        }
        
        API.login(body: LoginRequest(username: "sampson", password : "sampson")) { authResponse in
            UserStore.mainUser = authResponse.user!
            
            let now = Date()
            
            let aram = Event(name: "ARAM", details: "With Raikore", start: now, end: now.addingTimeInterval(2000), timezoneCreatedIn: "EST", owner: UserStore.mainUser!)
            
            let timeblock = Timeblock(start: now.addingTimeInterval(2001), end: now.addingTimeInterval(4000))
            
            let dnd = Event(name: "dnd", details: "With Raikore", start: now.addingTimeInterval(4001), end: now.addingTimeInterval(6000), timezoneCreatedIn: "EST", owner: UserStore.mainUser!)
            
            let sr5 = Event(name: "sr5", details: "With Raikore", start: now.addingTimeInterval(6001), end: now.addingTimeInterval(8000), timezoneCreatedIn: "EST", owner: UserStore.mainUser!)
            
            let tt3 = Event(name: "tt3", details: "With Raikore", start: now.addingTimeInterval(8001), end: now.addingTimeInterval(10000), timezoneCreatedIn: "EST", owner: UserStore.mainUser!)
            
            let timeblocks: [Timeblock] = [aram, timeblock, dnd, sr5, tt3]
            TimeblockStore.timeblocks = timeblocks
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

