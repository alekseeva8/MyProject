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
    
    private let label = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let questionButton = UIButton()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(button)
        
        setLabel(label: label, text: "Log in to your account")

        subStackView.insertArrangedSubview(emailTextField, at: 0)
        subStackView.addArrangedSubview(passwordTextField)
        let arrayOfTextFields = [emailTextField, passwordTextField]
        setTextFields(array: arrayOfTextFields, arrayOfPlaceholders: ["E-mail", "Password"])
        
        setQuestionButton(button: questionButton, title: "Haven't got an account? Press here.")
        setButton(button: button, title: "LOG IN")
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    //MARK: - Button
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        //check if user have already have user ID
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (result, error) in
            guard let self = self else { return }
            
            if error == nil {
                let router = Router(presentor: self)
                router.showMainScreen()
            }
            else {
                Alert.sendAlertForLoginVC(self)
            }
        }
    }
    
    override func setQuestionButton(button: UIButton, title: String) {
        super.setQuestionButton(button: questionButton, title: title)
        button.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
    }
    @objc func questionButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
