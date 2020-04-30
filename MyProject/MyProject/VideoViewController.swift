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
    let videoLink = "https://www.youtube.com/embed/Rd4AGeReUIY"

    override func viewDidLoad() {
        super.viewDidLoad()
        videoWebView.load(URLRequest(url: URL(string: videoLink)!))
    }
}

