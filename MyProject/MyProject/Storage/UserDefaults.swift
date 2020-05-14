//
//  UserDefaults.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class MyUserDefaults {

    static func saveSignedValue() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "signed")
    }
}
