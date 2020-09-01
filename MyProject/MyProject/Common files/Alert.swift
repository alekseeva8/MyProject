//
//  Alert.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

struct Alert {
    
    static func sendAlertForSignupVC(_ sender: UIViewController) {
        let title = "Check entered information"
        let message = "Name and e-mail must not be empty. Password must contain more than 6 symbols"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func sendAlertForLoginVC(_ sender: UIViewController) {
        let title = "Incorrect login or password"
        let message = ""
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
}
