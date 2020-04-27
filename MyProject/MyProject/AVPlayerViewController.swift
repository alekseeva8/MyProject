//
//  AVPlayerViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class AVPlayerViewController: UIViewController {

    @IBOutlet weak var reverseView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            }
            else {
                playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundView(reverseView)
        setBackgroundView(playView)
        setBackgroundView(forwardView)
    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()
    }

    @IBAction func touchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    }

    @IBAction func touchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    //setting up background views of buttons
    func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }
}
