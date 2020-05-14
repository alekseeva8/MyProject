//
//  StackViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    var mainStackView: UIStackView
    var subStackView = UIStackView(arrangedSubviews: [])

    required init?(coder: NSCoder) {
        self.mainStackView = UIStackView(arrangedSubviews: [subStackView])
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        view.backgroundColor = UIColor(named: "BackgroundColor")
    }

    //MARK: - MainStackView
    func setMainStackViewLayout() {

        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 15

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        let insets = UIEdgeInsets(top: 40, left: 0, bottom: 60, right: 0)
        //the stack view pins its content to the relevant margin instead of its edge.
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = insets
    }

    //MARK: - Label
    func setLabel(label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 25)
    }

    //MARK: - Button
    func setButton(button: UIButton, title: String) {
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .yellow
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }

    //MARK: - SubStackView

    func setSubStackView(array: [UITextField], arrayOfPlaceholders: [String]) {
        for (index, item) in array.enumerated() {
            //item.textColor = UIColor(named: "TextFieldColor")
            item.borderStyle = .roundedRect
            item.placeholder = arrayOfPlaceholders[index]
            if item.placeholder == SignupViewController.passwordPlaceholder || item.placeholder == SignupViewController.repeatPasswordPlaceholder {
                item.isSecureTextEntry = true
            }
            item.heightAnchor.constraint(equalToConstant: 34).isActive = true
            subStackView.addArrangedSubview(item)
        }
    }
    func subStackViewLayout() {
        subStackView.widthAnchor.constraint(equalToConstant: 335).isActive = true
        subStackView.axis = .vertical
        subStackView.alignment = .fill
        subStackView.distribution = .fill
        subStackView.spacing = 20
    }
}

