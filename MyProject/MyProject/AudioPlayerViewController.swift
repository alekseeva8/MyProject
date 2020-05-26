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
    var timer: Timer?
    var currentAudio = AudioManager.shared.currentAudio
    //let audio = AudioManager.shared.audio
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

    override var shouldAutorotate: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")

        imageView.image = audioArray[currentAudio].image
        audioNameLabel.text = audioArray[currentAudio].name

        //setting timeSlider
        timeSlider.setThumbImage(UIImage(named: "round"), for: .normal)
        //timer for timeSlider
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimeSlider), userInfo: nil, repeats: true)

        setBackgroundView(reverseView)
        setBackgroundView(playView)
        setBackgroundView(forwardView)

        //setting volumeSlider
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0

        guard let url = audioArray[currentAudio].url else {return}
        prepareAudioToPlay(url: url)
    }

     override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // stop timer when view disappear
        timer?.invalidate()
    }
    
    //MARK: - Functions
    //setting up background views of buttons
    func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }
    
    //MARK: - AVAudioPlayer prepareToPlay()

    func prepareAudioToPlay(url: URL) {

        AudioHandler.getAudioURL(url: url) {[weak self] (url) in
            guard let self = self else {return}
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                DispatchQueue.main.async {
                    self.timeSlider.maximumValue = Float(self.audioPlayer.duration)
                }
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
            self.prepareAudioToPlay(url: url)
            self.audioPlayer.play()
        }
        else {
            let previousSongIndex = self.currentAudio - 1
            self.audioNameLabel.text = self.audioArray[previousSongIndex].name
            self.imageView.image = self.audioArray[previousSongIndex].image
            let previousSong = self.audioArray[previousSongIndex]
            guard let url = previousSong.url else {return}
            self.prepareAudioToPlay(url: url)
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
            self.prepareAudioToPlay(url: url)
            self.currentAudio += 1
        }
        else {
            self.currentAudio = 0
            self.audioNameLabel.text = self.audioArray[0].name
            self.imageView.image = self.audioArray[0].image
            guard let url = self.audioArray[0].url else {return}
            self.prepareAudioToPlay(url: url)
        }
    }

    //MARK: - timeSlider
    @IBAction func timeSliderScrolled(_ sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(sender.value)
        audioPlayer.play()
    }

    @objc func updateTimeSlider() {
        timeSlider.value = Float(audioPlayer.currentTime)
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
