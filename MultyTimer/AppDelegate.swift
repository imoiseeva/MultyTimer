//
//  AppDelegate.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 02.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = UINavigationController(rootViewController: MainViewController())
            return true
        }


}

