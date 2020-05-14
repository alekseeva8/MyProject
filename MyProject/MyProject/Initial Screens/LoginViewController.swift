//
//  LoginViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/10/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class LoginStackViewController: StackViewController {

    let label = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainStackView.insertArrangedSubview(label, at: 0)
        mainStackView.addArrangedSubview(button)
        setMainStackViewLayout()

        setLabel(label: label, text: "Login to your account")

        let arrayOfTextFields = [usernameTextField, passwordTextField]
        setSubStackView(array: arrayOfTextFields, arrayOfPlaceholders: ["Username", "Password"])
        subStackViewLayout()

        setButton(button: button, title: "LOG IN")
    }


    //MARK: - Button
    override func setButton(button: UIButton, title: String) {
        super.setButton(button: button, title: title)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    //MARK: - Button's action
    @objc func buttonPressed(sender: UIButton) {
        //performSegue(withIdentifier: "", sender: nil)
    }
}

