//
//  Validator.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

class Validator {
    
    var text = ""
    var password = ""
    var repeatPassword = ""
    
    func isLoginCorrect(text: String) -> Bool {
        text.count > 0 ? true : false
    }
    
    func isEmailCorrect(text: String) -> Bool {
        validateEmail(text: text)
    }

    private func validateEmail(text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }
    
    func isPasswordCorrect(password: String) -> Bool {
        password.count >= 6 ? true : false 
    }
    
    func isRepeatPasswordCorrect(password: String, repeatPassword: String) -> Bool {
        password == repeatPassword
    }
    
    func setNameErrorLabel (with text: String) -> String {
        text.isEmpty ? "This field can't be empty" : ""
    }

    func setEmailErrorLabel (with text: String) -> String {
        var errorLabelText = ""
        switch text.isEmpty {
        case true:
            errorLabelText = "This field can't be empty"
        default: 
            let emailIsCorrect =  validateEmail(text: text)
            errorLabelText = emailIsCorrect ? "" : "E-mail is not valid"
        }
        return errorLabelText
    }

    func setPasswordErrorLabel (with text: String) -> String {
        text.count < 6 ? "Password must contain at least 6 symbols" : ""
    }

    func setRepeatPasswErrorLabel (password: String, repeatPassword: String) -> String {
        password != repeatPassword ? "You've entered wrong password" : ""
    }
}
