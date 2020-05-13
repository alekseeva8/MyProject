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
    let song = AudioManager.shared.song
    let story = AudioManager.shared.story
    
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
        if song.kind == "song" {
            audioNameLabel.text = song.name
            imageView.image = song.image
            guard let url = song.url else {return}
            preparingAudioToPlay(url: url)
        }
        else if story.kind == "story" {
            audioNameLabel.text = story.name
            imageView.image = story.image
            guard let url = story.url else {return}
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
        if self.audioPlayer.isPlaying {
//            if self.currentAudio == 0 {
//                self.audioNameLabel.text = self.songsArray[0].name
//                self.imageView.image = self.songsArray[0].image
//                guard let url = self.songsArray[0].url else {return}
//                self.preparingAudioToPlay(url: url)
//                self.audioPlayer.play()
//            }
//            else {
//                let previousSongIndex = self.currentAudio - 1
//                self.audioNameLabel.text = self.songsArray[previousSongIndex].name
//                self.imageView.image = self.songsArray[previousSongIndex].image
//                let previousSong = self.songsArray[previousSongIndex]
//                guard let url = previousSong.url else {return}
//                self.preparingAudioToPlay(url: url)
//                self.audioPlayer.play()
//                self.currentAudio -= 1
            }
        }

    @IBAction func prevButtonTouchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }


    //MARK: - NextButton

    @IBAction func nextButtonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        //                if self.audioPlayer.isPlaying {
        //                    if self.currentAudio < self.songsArray.count-1 {
        //                        let nextSongNumber = self.currentAudio + 1
        //                        self.audioNameLabel.text = self.songsArray[nextSongNumber].name
        //                        self.imageView.image = self.songsArray[nextSongNumber].image
        //                        let nextSong = self.songsArray[nextSongNumber]
        //                        guard let url = nextSong.url else {return}
        //                        self.preparingAudioToPlay(url: url)
        //                        self.audioPlayer.play()
        //                        self.currentAudio += 1
        //                    }
        //                    else {
        //                        self.currentAudio = 0
        //                        self.audioNameLabel.text = self.songsArray[0].name
        //                        self.imageView.image = self.songsArray[0].image
        //                        guard let url = self.songsArray[0].url else {return}
        //                        self.preparingAudioToPlay(url: url)
        //                        self.audioPlayer.play()
        //                    }
        //                }

    }

    @IBAction func nextButtonTouchedUpInside(_ sender: UIButton) {
sender.transform = CGAffineTransform.identity
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
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
    }
}
