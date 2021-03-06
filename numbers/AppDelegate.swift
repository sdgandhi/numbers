//
//  AppDelegate.swift
//  numbers
//
//  Created by Sidhant Gandhi on 5/11/20.
//  Copyright © 2020 NewNoetic, Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Arguments
        let arguments = CommandLine.arguments
        if arguments.contains("--disableAnimation") {
            UIView.setAnimationsEnabled(false)
        }
        if arguments.contains("-testing") {
            print("detected testing env: disabling analytics collection")
//            Analytics.setAnalyticsCollectionEnabled(false)
        }
        if arguments.contains("--disableIntro") {}
        if arguments.contains("--showTaps") {
            ShowTaps.enabled = .debugOnly
        } else {
            ShowTaps.enabled = .never
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

