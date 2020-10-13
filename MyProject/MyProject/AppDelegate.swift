//
//  AppDelegate.swift
//  MyProject
//
//  Created by Elena Alekseeva on 3/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let initialVC = Router.setInitialScreen()
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }
}
