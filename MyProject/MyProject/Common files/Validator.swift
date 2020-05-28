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
    var loginIsCorrect = false
    var passwordIsCorrect = false
    
    init() {
    }
    
    func isLoginCorrect(text: String) -> Bool {
        if text.count > 0 {
            loginIsCorrect = true
        } else {
            loginIsCorrect = false
        }
        return loginIsCorrect
    }
    
    func isEmailCorrect(text: String) -> Bool {
        let emailIsCorrect = validateEmail(text: text)
        return emailIsCorrect
    }

    func validateEmail(text: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: text)
    }
    
    func isPasswordCorrect(password: String) -> Bool {
        if password.count >= 6 {
            passwordIsCorrect = true
        } else {
            passwordIsCorrect = false
        }
        return passwordIsCorrect
    }
    
    func isRepeatPasswordCorrect(password: String, repeatPassword: String) -> Bool {
        password == repeatPassword
    }

    func setNameErrorLabel (tfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if tfText.isEmpty {
            errorLabelText = "This field can't be empty"
        } else {
            errorLabelText = ""
        }
        return errorLabelText
    }

    func setEmailErrorLabel (tfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if tfText.isEmpty {
            errorLabelText = "This field can't be empty"
        } else {
            let emailIsCorrect =  validateEmail(text: tfText)
            if emailIsCorrect == true {
                errorLabelText = ""
            }
            else {
                errorLabelText = "Incorrect e-mail"
            }
        }
        return errorLabelText
    }

    func setPasswordErrorLabel (tfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if tfText.count < 6 {
            errorLabelText = "Password must contain at least 6 symbols"
        } else {
            errorLabelText = ""
        }
        return errorLabelText
    }

    func setRepeatPasswErrorLabel (passwtfText: String, repeatPasswtfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if passwtfText != repeatPasswtfText {
            errorLabelText = "Incorrect password"
        } else {
            errorLabelText = ""
        }
        return errorLabelText
    }
}
