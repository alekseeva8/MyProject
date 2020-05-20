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
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let questionButton = UIButton()
    let button = UIButton()
    static let passwordPlaceholder = "Password"
    static let repeatPasswordPlaceholder = "Repeat password"

    override func viewDidLoad() {
        super.viewDidLoad()

        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(questionButton)
        mainStackView.addArrangedSubview(button)
        //setting MainStackView and it's elements (label,subStackView, questionButton, button)

        setLabel(label: label, text: "Welcome to the world of joy!\nPlease sign up.")

        let arrayOfTextFields = [nameTextField, usernameTextField, passwordTextField, repeatPasswordTextField]
        setSubStackView(array: arrayOfTextFields, arrayOfPlaceholders: ["Name", "Username/E-mail", SignupViewController.passwordPlaceholder, SignupViewController.repeatPasswordPlaceholder])

        setQuestionButton(button: questionButton, title: "Have already have an account? Log in please.")

        setButton(button: button, title: "SIGN UP")
    }


    //MARK: - Buttons
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped(sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""

        //checking the validation of login and password
        let validator = Validator()
        if validator.isPasswordCorrect(password: password) == true && validator.isRepeatPasswordCorrect(password: password, repeatPassword: repeatPassword) {
            Auth.auth().createUser(withEmail: username, password: password) {(result, error) in
                print("user is created")
                print(result?.user.uid)
            }
            //saving the fact of user's registration
            MyUserDefaults.saveSignedValue()
            performSegue(withIdentifier: "fromSignupToMainVC", sender: nil)
        } else {
            Alert.alertSending(self)
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
