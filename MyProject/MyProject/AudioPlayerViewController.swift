//
//  AVPlayerViewController.swift
//  MyProject
//
//  Created by Elena Alekseeva on 4/22/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import  AVFoundation

class AudioPlayerViewController: UIViewController {

    //var audioPlayer2 = AVPlayer()
    var audioPlayer = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "Rio", ofType: "mp3")

    @IBOutlet weak var reverseView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundView(reverseView)
        setBackgroundView(playView)
        setBackgroundView(forwardView)

        //setting timeSlider
        timeSlider.minimumValue = 0.0
        //setting volumeSlider
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0

        //AVAudioPlayer
        let url = URL(fileURLWithPath: path ?? "")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            timeSlider.maximumValue = Float(audioPlayer.duration)
        } catch let error {
            print(error)
        }
        //audioPlayer = AVPlayer(url: url)
        audioPlayer.prepareToPlay()

    }

    //MARK: Functions
    //setting up background views of buttons
    func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if audioPlayer.isPlaying == false {
            audioPlayer.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        else {
            audioPlayer.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }

    @IBAction func touchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            if sender == self.reverseButton {
                if self.audioPlayer.isPlaying {
                    self.audioPlayer.currentTime = 0
                    self.audioPlayer.play()
                }
                else {
                    //НУЖНО ЛИ ЧТОБЫ ПРОИГРЫВАЛ ПРИ РЕСТАРТЕ?
                    self.audioPlayer.play()
                }
            }
            if sender == self.forwardButton {
                if self.audioPlayer.isPlaying {
                    self.audioPlayer.currentTime = 1
                    //ЗДЕСЬ РЕАЛИЗОВАТЬ ПЕРЕКЛЮЧЕНИЕ НА NEXT SONG
                    self.audioPlayer.stop()
                    self.playPauseButton.setImage(UIImage(named: "play"), for: .normal)
                }
            }
    }
    }

    @IBAction func touchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    //НЕУДАЧНЫЙ ЖЕСТ - ПРОБОВАТЬ ЗАМЕНИТЬ
    //ДОРОЖКА НЕ ОТОБРАЖАЕТСЯ
    @IBAction func timeSliderScrolled(_ sender: UISlider) {
        if sender == timeSlider {
            audioPlayer.currentTime = TimeInterval(sender.value)
            audioPlayer.play()
        }
    }

    @IBAction func volumeSliderScrolled(_ sender: UISlider) {
        if sender == volumeSlider {
        audioPlayer.volume = sender.value
        }
    }
}
