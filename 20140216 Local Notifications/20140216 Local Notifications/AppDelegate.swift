//
//  AppDelegate.swift
//  20140216 Local Notifications
//
//  Created by mihai.cristescu on 07/06/2017.
//  Copyright © 2017 Mihai Cristescu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let types = UIUserNotificationType.alert

        return true
    }
}

