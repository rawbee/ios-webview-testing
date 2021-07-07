//
//  AppDelegate.swift
//  WebViewTesting
//
//  Created by Robby Abaya on 6/23/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let vc = ViewController()
        self.window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }



}

