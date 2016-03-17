//
//  AppDelegate.swift
//  TouchTracker
//
//  Created by João Gradim on 17/03/16.
//  Copyright © 2016 jgradim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    let controller:RootViewController = RootViewController()
    
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {}
  func applicationDidEnterBackground(application: UIApplication) {}
  func applicationWillEnterForeground(application: UIApplication) {}
  func applicationDidBecomeActive(application: UIApplication) {}
  func applicationWillTerminate(application: UIApplication) {}
}

