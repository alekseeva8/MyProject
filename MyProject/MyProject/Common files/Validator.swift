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
    
    func isLoginContainsCorrectSymbols(text: String) -> Bool {
        var arrayOfActualSymbols: [Int] = []
        let rangeOfCorrectSymbols1 = 65...90
        let rangeOfCorrectSymbols2 = 48...57
        let rangeOfCorrectSymbols3 = 97...122
        for symbol in text.utf8 {
            arrayOfActualSymbols.append(Int(symbol))
        }
        var numberCorrect = 0
        arrayOfActualSymbols.forEach { (one) in
            if rangeOfCorrectSymbols1.contains(one) ||
                rangeOfCorrectSymbols2.contains(one) ||
                rangeOfCorrectSymbols3.contains(one) {
                numberCorrect += 1
            }
        }
        return numberCorrect == text.count
    }
    
    func isEmailCorrect(text: String) -> Bool {
        if text.contains("@") && text.contains(".") {
            return true
        }
        else {
            return false
        }
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
        }
        else {
            errorLabelText = ""
        }
        return errorLabelText
    }

    func setEmailErrorLabel (tfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if tfText.isEmpty {
            errorLabelText = "This field can't be empty"
        }
        else {
            if tfText.contains("@") && tfText.contains(".") {
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
        }
        else {
            errorLabelText = ""
        }
        return errorLabelText
    }

    func setRepeatPasswErrorLabel (passwtfText: String, repeatPasswtfText: String, errorLabelText: String) -> String {
        var errorLabelText = errorLabelText
        if passwtfText != repeatPasswtfText {
            errorLabelText = "Incorrect password"
        }
        else {
            errorLabelText = ""
        }
        return errorLabelText
    }


}
