//
//  SceneDelegate.swift
//  MyProject
//
//  Created by Elena Alekseeva on 3/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // chosing the screen to be loaded [SignupVC or MainVC]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        //choosing initial VC by checking UserDefault's value (signed or not)
        let isSigned = UserDefaults.standard.value(forKey: "signed") as? Bool
        var initialVC = UIViewController()
        if isSigned == true {
            // open MainVC
            initialVC = storyboard.instantiateViewController(withIdentifier: "MainNavigationVC")
        } else {
            // open SignupVC
            initialVC = storyboard.instantiateViewController(withIdentifier: "SignupVC")
        }

        self.window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
