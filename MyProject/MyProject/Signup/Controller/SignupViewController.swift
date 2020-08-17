//
//  SignupViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

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
    private let button = UIButton()
    private let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting MainStackView and it's elements (label,subStackView, questionButton, button)
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(button)
        
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
        configureButton(button, with: "SIGN UP")
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }

    //MARK: - TextFields' methods
    @objc func nameTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        nameErrorLabel.text = validator.setNameErrorLabel(with: text)
        nameErrorLabel.textColor = .red
    }

    @objc func emailTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        emailErrorLabel.text = validator.setEmailErrorLabel(with: text)
        emailErrorLabel.textColor = .red
    }

    @objc func passwordTFChanged(sender: UITextField) {
        let text = sender.text ?? ""
        passwordErrorLabel.text = validator.setPasswordErrorLabel(with: text)
        passwordErrorLabel.textColor = .red
    }

    @objc func repeatPasswordTFChanged(sender: UITextField) {
        let password = passwordTextField.text ?? ""
        let repeatPassword = sender.text ?? ""
        repeatPasswErrorLabel.text = validator.setRepeatPasswErrorLabel(
            password: password,
            repeatPassword: repeatPassword)
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
        
        //checking the validation of login and password
        if validator.isLoginCorrect(text: name) &&
            validator.isLoginCorrect(text: email) &&
            validator.isEmailCorrect(text: email) &&
            validator.isPasswordCorrect(password: password) == true &&
            validator.isRepeatPasswordCorrect(password: password, repeatPassword: repeatPassword) {
            Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            }
            let router = Router(presentor: self)
            router.showMainScreen()
        } else {
            Alert.sendAlertForSigninVC(self)
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
