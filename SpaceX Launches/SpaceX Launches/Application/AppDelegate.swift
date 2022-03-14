//
//  AppDelegate.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 10/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        let navigationController = UINavigationController()
        let homeVC = HomeVC(viewModel: HomeVM())
        navigationController.setViewControllers([homeVC], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}

