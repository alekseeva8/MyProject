//
//  VideoViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var videoWebView: WKWebView!

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: Constants.videoLink) else {return}
        videoWebView.load(URLRequest(url: url))
    }
}

