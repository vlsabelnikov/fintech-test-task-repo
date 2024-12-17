//
//  AppDelegate.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.rootViewController = UINavigationController(rootViewController: CurrencyConverterViewController())
        NetworkMonitor.shared.startMonitoring()
        // Override point for customization after application launch.
        return true
    }

}

