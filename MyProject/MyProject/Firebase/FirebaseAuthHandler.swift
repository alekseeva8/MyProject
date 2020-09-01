//
//  FirebaseAuthHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 9/1/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import  FirebaseAuth

class FirebaseAuthHandler {
    
    static func logIn(_ viewController: UIViewController, email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak viewController] (result, error) in
            guard let viewController = viewController else { return }
            
            if error == nil {
                let router = Router(presentor: viewController)
                router.showMainScreen()
            }
            else {
                Alert.sendAlertForLoginVC(viewController)
            }
        }
    }
}
