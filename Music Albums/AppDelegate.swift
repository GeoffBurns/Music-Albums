//
//  AppDelegate.swift
//  Music Albums
//
//  Created by Geoff Burns on 17/12/2015.
//  Copyright © 2015 Geoff Burns. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    let appDependencies = AppDependencies()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool  {
        
        if let window = self.window
        {
        appDependencies.installRootViewControllerIntoWindow(window)
        }
        return true
    }


}

