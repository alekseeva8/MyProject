//
//  Validator.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Validator {
    
    static func isNotEmpty(_ text: String) -> Bool {
        text.count > 0 ? true : false
    }
    
    static func isEmailValid(_ text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }
    
    static func isEnoughSymbols(_ text: String) -> Bool {
        text.count >= 6 ? true : false 
    }
    
    static func isEqual(_ text1: String, _ text2: String) -> Bool {
        text1.elementsEqual(text2)
    }
    
    //MARK: - validateSignupInfo()
    static func validateSignupInfo(_ name: String, _ email: String, _ password: String, _ repeatPassword: String) -> Bool {
        isNotEmpty(name) &&
        isNotEmpty(email) &&
        isEmailValid(email) &&
        isNotEmpty(password) &&
        isEnoughSymbols(password) &&
        isEqual(password, repeatPassword)
    }

    //MARK: - Error labels 
    static func setNameErrorLabel (for text: String) -> String {
        text.isEmpty ? "This field can't be empty" : ""
    }
    
    static func setEmailErrorLabel (for text: String) -> String {
        var errorLabelText = ""
        switch text.isEmpty {
        case true:
            errorLabelText = "This field can't be empty"
        default: 
            errorLabelText = isEmailValid(text) ? "" : "E-mail is not valid"
        }
        return errorLabelText
    }
    
    static func setPasswordErrorLabel (for text: String) -> String {
        isEnoughSymbols(text) ? "" : "Password must contain at least 6 symbols"
    }
    
    static func setRepeatPasswErrorLabel (_ password: String, _ repeatPassword: String) -> String {
        isEqual(password, repeatPassword) ? "" : "You've entered wrong password"
    }
}
