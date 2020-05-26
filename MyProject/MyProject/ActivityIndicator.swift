//
//  ActivityIndicator.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/25/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class AppActivityIndicator {

    static func activityIndicatorLayout(activityIndicator: UIActivityIndicatorView, superview: UIScrollView) {
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true
    }
}

