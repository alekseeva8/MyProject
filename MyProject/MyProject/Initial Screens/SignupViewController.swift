//
//  SignupViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import FirebaseAuth
import  Firebase

class SignupViewController: StackViewController {
    
    let label = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let nameErrorLabel = UILabel()
    let emailErrorLabel = UILabel()
    let passwordErrorLabel = UILabel()
    let repeatPasswErrorLabel = UILabel()
    let questionButton = UIButton()
    let button = UIButton()
    static let passwordPlaceholder = "Password"
    static let repeatPasswordPlaceholder = "Repeat password"
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting MainStackView and it's elements (label,subStackView, questionButton, button)
        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(button)
        
        setLabel(label: label, text: "Welcome to the world of joy!\nPlease sign up.")

        subStackView.insertArrangedSubview(nameTextField, at: 0)
        subStackView.addArrangedSubview(nameErrorLabel)
        subStackView.addArrangedSubview(emailTextField)
        subStackView.addArrangedSubview(emailErrorLabel)
        subStackView.addArrangedSubview(passwordTextField)
        subStackView.addArrangedSubview(passwordErrorLabel)
        subStackView.addArrangedSubview(repeatPasswordTextField)
        subStackView.addArrangedSubview(repeatPasswErrorLabel)

        let arrayOfTextFields = [nameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        setTextFields(array: arrayOfTextFields, arrayOfPlaceholders: ["Name", "E-mail", SignupViewController.passwordPlaceholder, SignupViewController.repeatPasswordPlaceholder])
        nameTextField.addTarget(self, action: #selector(nameTFChanged(sender:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(emailTFChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTFChanged), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(repeatPasswordTFChanged), for: .editingChanged)

        let arrayOfLabels = [nameErrorLabel, emailErrorLabel, passwordErrorLabel, repeatPasswErrorLabel]
        setLabels(array: arrayOfLabels, text: ["", "", "", ""])
        
        setQuestionButton(button: questionButton, title: "Have already have an account? Press here.")
        setButton(button: button, title: "SIGN UP")
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }


    //MARK: - TextFields' methods
    @objc func nameTFChanged(sender: UITextField) {
        nameErrorLabel.text = validator.setNameErrorLabel(tfText: sender.text ?? "", errorLabelText: nameErrorLabel.text ?? "")
        nameErrorLabel.textColor = .red
    }

    @objc func emailTFChanged(sender: UITextField) {
        emailErrorLabel.text = validator.setEmailErrorLabel(tfText: sender.text ?? "", errorLabelText: emailErrorLabel.text ?? "")
        emailErrorLabel.textColor = .red
    }

    @objc func passwordTFChanged(sender: UITextField) {
        passwordErrorLabel.text = validator.setPasswordErrorLabel(tfText: sender.text ?? "", errorLabelText: passwordErrorLabel.text ?? "")
        passwordErrorLabel.textColor = .red
    }

    @objc func repeatPasswordTFChanged(sender: UITextField) {
        repeatPasswErrorLabel.text = validator.setRepeatPasswErrorLabel(passwtfText: passwordTextField.text ?? "", repeatPasswtfText: sender.text ?? "", errorLabelText: repeatPasswErrorLabel.text ?? "")
        repeatPasswErrorLabel.textColor = .red
    }
    
    //MARK: - Buttons
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""
        
        //checking the validation of login and password
        if validator.isLoginCorrect(text: name) && validator.isLoginCorrect(text: email) && validator.isEmailCorrect(text: email) && validator.isPasswordCorrect(password: password) == true && validator.isRepeatPasswordCorrect(password: password, repeatPassword: repeatPassword) {
            Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
            }
            //saving the fact of user's registration
            UserDefaults.standard.set(true, forKey: "signed")
            performSegue(withIdentifier: "fromSignupToMainVC", sender: nil)
        } else {
            Alert.sendAlertForSigninVC(self)
        }
    }
    
    override func setQuestionButton(button: UIButton, title: String) {
        super.setQuestionButton(button: questionButton, title: title)
        button.addTarget(self, action: #selector(questionButtonPressed), for: .touchUpInside)
    }
    @objc func questionButtonPressed(sender: UIButton) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
}

//MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        }
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField {
            repeatPasswordTextField.becomeFirstResponder()
        }
        if textField == repeatPasswordTextField {
            repeatPasswordTextField.resignFirstResponder()
        }
        return true
    }
}
