//
//  LoginViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import  FirebaseAuth

class LoginViewController: StackViewController {
    
    let label = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let questionButton = UIButton()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(button)
        
        setLabel(label: label, text: "Log in to your account")
        let arrayOfTextFields = [usernameTextField, passwordTextField]
        setSubStackView(array: arrayOfTextFields, arrayOfPlaceholders: ["E-mail", "Password"])
        setQuestionButton(button: questionButton, title: "Haven't got an account? Press here.")
        setButton(button: button, title: "LOG IN")
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        //usernameTextField.becomeFirstResponder()
    }
    
    
    //MARK: - Button
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        //check if user have already have user ID
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: username, password: password) {[weak self] (result, error) in
            guard let self = self else { return }
            if error == nil {
                //saving the fact of user's logging in
                UserDefaults.standard.set(true, forKey: "signed")
                self.performSegue(withIdentifier: "fromLoginToMainVC", sender: nil)
            }
            else {
                print(error)
                Alert.sendAlert(self)
            }
        }
    }
    
    override func setQuestionButton(button: UIButton, title: String) {
        super.setQuestionButton(button: questionButton, title: title)
        button.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
    }
    @objc func questionButtonPressed(sender: UIButton) {
        performSegue(withIdentifier: "toSignupVC", sender: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}


