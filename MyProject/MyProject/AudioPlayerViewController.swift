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

    var audioPlayer = AVAudioPlayer()

    var currentAudio = AudioManager.shared.currentAudio
    var kind = ""
    let audio = AudioManager.shared.audio
    var audioArray: [Audio] = []
    
    @IBOutlet weak var reverseView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var timeProgressView: UIProgressView!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var audioNameLabel: UILabel!
    
    //MARK: - ViewDidLoad
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

        choosingAudioToPlay()
    }
    
    //MARK: - Functions
    //setting up background views of buttons
    func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }

    func choosingAudioToPlay() {
        if kind == "song" {
            audioNameLabel.text = audio.name
            imageView.image = audio.image
            guard let url = audio.url else {return}
            preparingAudioToPlay(url: url)
        }
        else if kind == "story" {
            audioNameLabel.text = audio.name
            imageView.image = audio.image
            guard let url = audio.url else {return}
            preparingAudioToPlay(url: url)
        }
    }
    
    //MARK: - AVAudioPlayer prepareToPlay()

    func preparingAudioToPlay(url: URL) {
        NetworkManager.downloadFileFrom(url: url) { (url) in
            print("downloaded")
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                //timeSlider.maximumValue = Float(audioPlayer.duration)
            } catch {
                print(error)
            }
            self.audioPlayer.delegate = self
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            DispatchQueue.main.async {
                self.playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            }
        }
    }

    
    //MARK: - playPauseButton
    @IBAction func playPauseButtonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        if audioPlayer.isPlaying == false {
            audioPlayer.play()
            if audioPlayer.isPlaying == true {
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            }
        }
        else {
            audioPlayer.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }

    @IBAction func playPauseButtonTouchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    
    //MARK: - PrevButton
    @IBAction func prevButtonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        playPrevious()
    }

    @IBAction func prevButtonTouchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    func playPrevious() {
        if self.currentAudio == 0 {
            self.audioNameLabel.text = self.audioArray[0].name
            self.imageView.image = self.audioArray[0].image
            guard let url = self.audioArray[0].url else {return}
            self.preparingAudioToPlay(url: url)
            self.audioPlayer.play()
        }
        else {
            let previousSongIndex = self.currentAudio - 1
            self.audioNameLabel.text = self.audioArray[previousSongIndex].name
            self.imageView.image = self.audioArray[previousSongIndex].image
            let previousSong = self.audioArray[previousSongIndex]
            guard let url = previousSong.url else {return}
            self.preparingAudioToPlay(url: url)
            self.audioPlayer.play()
            self.currentAudio -= 1
        }
    }


    //MARK: - NextButton

    @IBAction func nextButtonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        playNext()
    }

    @IBAction func nextButtonTouchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    func playNext() {
        if self.currentAudio < self.audioArray.count-1 {
            let nextSongNumber = self.currentAudio + 1
            self.audioNameLabel.text = self.audioArray[nextSongNumber].name
            self.imageView.image = self.audioArray[nextSongNumber].image
            let nextSong = self.audioArray[nextSongNumber]
            guard let url = nextSong.url else {return}
            self.preparingAudioToPlay(url: url)
            self.currentAudio += 1
        }
        else {
            self.currentAudio = 0
            self.audioNameLabel.text = self.audioArray[0].name
            self.imageView.image = self.audioArray[0].image
            guard let url = self.audioArray[0].url else {return}
            self.preparingAudioToPlay(url: url)
        }
    }

    
    //MARK: - timeSlider
    @IBAction func timeSliderScrolled(_ sender: UISlider) {
        if sender == timeSlider {
            audioPlayer.currentTime = TimeInterval(sender.value)
            audioPlayer.play()
        }
    }
    
    //MARK: - volumeSlider
    @IBAction func volumeSliderScrolled(_ sender: UISlider) {
        if sender == volumeSlider {
            audioPlayer.volume = sender.value
        }
    }
}

extension AudioPlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNext()
    }
}
