//
//  SignupViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SignupViewController: StackViewController {
    
    private let label = UILabel()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let repeatPasswordTextField = UITextField()
    private let nameErrorLabel = UILabel()
    private let emailErrorLabel = UILabel()
    private let passwordErrorLabel = UILabel()
    private let repeatPasswErrorLabel = UILabel()
    private let questionButton = UIButton()
    private let signupButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting MainStackView and it's elements (label, subStackView, questionButton, signupButton)
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(signupButton)
        
        configureLabel(label, with: "Welcome to the world of joy!\nPlease sign up.")

        subStackView.insertArrangedSubview(nameTextField, at: 0)
        subStackView.addArrangedSubview(nameErrorLabel)
        subStackView.addArrangedSubview(emailTextField)
        subStackView.addArrangedSubview(emailErrorLabel)
        subStackView.addArrangedSubview(passwordTextField)
        subStackView.addArrangedSubview(passwordErrorLabel)
        subStackView.addArrangedSubview(repeatPasswordTextField)
        subStackView.addArrangedSubview(repeatPasswErrorLabel)

        let textFields = [nameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        let placeholders = ["Name", "E-mail", Constants.passwPlaceholder, Constants.repeatPasswPlaceholder]
        configureTextFields(textFields, with: placeholders)
        
        nameTextField.addTarget(self, action: #selector(nameTFChanged(sender:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTFChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTFChanged), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(repeatPasswordTFChanged), for: .editingChanged)

        let errorLabels = [nameErrorLabel, emailErrorLabel, passwordErrorLabel, repeatPasswErrorLabel]
        let texts = ["", "", "", ""]
        configureErrorLabels(errorLabels, with: texts)
        
        configureQuestionButton(questionButton, with: "Have already have an account? Press here.")
        configureButton(signupButton, with: "SIGN UP")
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }

    //MARK: - TextFields' methods
    @objc func nameTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        nameErrorLabel.text = Validator.setNameErrorLabel(for: text)
        nameErrorLabel.textColor = .red
    }

    @objc func emailTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        emailErrorLabel.text = Validator.setEmailErrorLabel(for: text)
        emailErrorLabel.textColor = .red
    }

    @objc func passwordTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        passwordErrorLabel.text = Validator.setPasswordErrorLabel(for: text)
        passwordErrorLabel.textColor = .red
    }

    @objc func repeatPasswordTFChanged(sender: UITextField) {
        let password = passwordTextField.text ?? ""
        let repeatPassword = sender.text ?? ""
        repeatPasswErrorLabel.text = Validator.setRepeatPasswErrorLabel(password, repeatPassword)
        repeatPasswErrorLabel.textColor = .red
    }
    
    //MARK: - Buttons
    override func configureButton(_ button: UIButton, with title: String) {
        super.configureButton(button, with: title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        let isSignupInfoValid = Validator.validateSignupInfo(name, email, password, repeatPassword)
        
        switch isSignupInfoValid {
        case true:
            FirebaseAuthHandler.signUp(self, email: email, password: password)
        default:
            Alert.sendAlertForSignupVC(self)
        }
    }

    override func configureQuestionButton(_ button: UIButton, with title: String) {
        super.configureQuestionButton(questionButton, with: title)
        button.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
    }
    @objc func questionButtonPressed(sender: UIButton) {
        let router = Router(presentor: self)
        router.showLoginScreen()
    }
}

//MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            repeatPasswordTextField.becomeFirstResponder()
        case repeatPasswordTextField:
            repeatPasswordTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
