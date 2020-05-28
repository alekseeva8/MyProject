//
//  Alert.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class Alert {
    static func sendAlertForSigninVC(_ sender: UIViewController) {
        let alert = UIAlertController(title: "Check entered information", message: "Name and e-mail must not be empty. Password must contain more than 6 symbols", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
    
    static func sendAlertForLoginVC(_ sender: UIViewController) {
        let alert = UIAlertController(title: "Incorrect login or password", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        sender.present(alert, animated: true, completion: nil)
    }
}
