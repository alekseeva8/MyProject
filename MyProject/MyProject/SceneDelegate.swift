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
        
        // choosing the screen to be loaded by checking UserDefault's value (signed or not)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let isSigned = UserDefaults.standard.value(forKey: "signed") as? Bool
        var initialVC = UIViewController()
        
        switch isSigned {
        case true: 
            initialVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC")
        default: 
            initialVC = storyboard.instantiateViewController(withIdentifier: "SignupVC")
        }
        
        self.window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
    }
}
