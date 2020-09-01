//
//  LoginViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class LoginViewController: StackViewController {
    
    private let label = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let questionButton = UIButton()
    private let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(loginButton)
        
        configureLabel(label, with: "Log in to your account")

        subStackView.insertArrangedSubview(emailTextField, at: 0)
        subStackView.addArrangedSubview(passwordTextField)
        
        let textFields = [emailTextField, passwordTextField]
        let placeholders = ["E-mail", "Password"]
        configureTextFields(textFields, with: placeholders)
        
        configureQuestionButton(questionButton, with: "Haven't got an account? Press here.")
        configureButton(loginButton, with: "LOG IN")
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    //MARK: - Buttons
    override func configureButton(_ button: UIButton, with title: String) {
        super.configureButton(button, with: title)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        FirebaseAuthHandler.logIn(self, email: email, password: password)
    }
    
    override func configureQuestionButton(_: UIButton, with title: String) {
        super.configureQuestionButton(questionButton, with: title)
        questionButton.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
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
