//
//  StackViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/14/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    
    var mainStackView = UIStackView(arrangedSubviews: [])
    var subStackView = UIStackView(arrangedSubviews: [])
    
    required init?(coder: NSCoder) {
        self.mainStackView.insertArrangedSubview(subStackView, at: 0)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainStackView)
        view.backgroundColor = UIColor.backgroundColor
        configureMainStack()
        configureSubStack()
    }
    
    //MARK: - configureMainStack()
    func configureMainStack() {
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 30
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let insets = UIEdgeInsets(top: 40, left: 0, bottom: 120, right: 0)
        //the stack view pins its content to the relevant margin instead of its edge.
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = insets
    }
    
    //MARK: - configureSubStack()

    func configureSubStack() {
        subStackView.widthAnchor.constraint(equalToConstant: 335).isActive = true
        subStackView.axis = .vertical
        subStackView.alignment = .fill
        subStackView.distribution = .fill
        subStackView.spacing = 10
    }
    
    //MARK: - configureLabel()
    func configureLabel(_ label: UILabel, with text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 2
        label.textAlignment = .center
    }
    
    //MARK: - configureButton()
    func configureButton(_ button: UIButton, with title: String) {
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .yellow
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }

    
    //MARK: - configureQuestionButton()    
    func configureQuestionButton(_ button: UIButton, with title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
    }

    //MARK: - configureTextFields()    
    func configureTextFields(_ dictionary: [UITextField : String]) {
        dictionary.forEach { (textField, placeholder) in
            textField.borderStyle = .roundedRect
            textField.placeholder = placeholder
            if textField.placeholder == Constants.passwPlaceholder || textField.placeholder == Constants.repeatPasswPlaceholder {
                textField.isSecureTextEntry = true
            }
            textField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        }
    }

    //MARK: - configureErrorLabels()
    func configureErrorLabels(_ dictionary: [UILabel : String]) {
        dictionary.forEach { (label, text) in
            label.text = text
            label.font = UIFont.systemFont(ofSize: 16)
        }
    }
}
