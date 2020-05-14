//
//  SignupViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SignupViewController: StackViewController {

    let label = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let repeatPasswordTextField = UITextField()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(button)
        //setting MainStackView and it's elements (label,subStackView, button)
        setMainStackViewLayout()

        setLabel(label: label, text: "Signing up")

        let arrayOfTextFields = [usernameTextField, passwordTextField, repeatPasswordTextField]
        setSubStackView(array: arrayOfTextFields, arrayOfPlaceholders: ["Username", "Password", "Repeat password"])
        subStackViewLayout()

        setButton(button: button, title: "SIGN UP")
    }


    //MARK: - Button
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped(sender: UIButton) {
        MyUserDefaults.saveSignedValue()
        performSegue(withIdentifier: "fromSigninToMainVC", sender: nil)
    }
}
