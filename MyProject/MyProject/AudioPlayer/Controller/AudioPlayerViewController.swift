//
//  AudioPlayerViewController.swift
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
        
        guard let trackUrl = audioArray[currentAudio].url else {return}
        prepareAudioToPlay(trackUrl: trackUrl)
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
    // get url for AudioPlayer
    // if audio has already been downloaded and saved to file system - get newDirectoryURL
    // if it hasn't - audio is downloading from network and tmpDirectoryURL is being passed. (finally, audio is being saved to file system)
    func prepareAudioToPlay(trackUrl: URL) {
        AssetHandler.getAssetURL(url: trackUrl) {[weak self] (url) in
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
        switch audioPlayer.isPlaying {
        case false:
            audioPlayer.play()
            if audioPlayer.isPlaying == true {
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            }
        default:
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
        
        switch currentAudio {
        case 0:
            self.audioNameLabel.text = self.audioArray[0].name
            self.imageView.image = self.audioArray[0].image
            guard let trackUrl = self.audioArray[0].url else {return}
            self.prepareAudioToPlay(trackUrl: trackUrl)
            self.audioPlayer.play()
        default:
            let previousAudioNumber = self.currentAudio - 1
            self.audioNameLabel.text = self.audioArray[previousAudioNumber].name
            self.imageView.image = self.audioArray[previousAudioNumber].image
            let previousAudio = self.audioArray[previousAudioNumber]
            guard let trackUrl = previousAudio.url else {return}
            self.prepareAudioToPlay(trackUrl: trackUrl)
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
            let nextAudioNumber = self.currentAudio + 1
            self.audioNameLabel.text = self.audioArray[nextAudioNumber].name
            self.imageView.image = self.audioArray[nextAudioNumber].image
            let nextAudio = self.audioArray[nextAudioNumber]
            guard let trackUrl = nextAudio.url else {return}
            self.prepareAudioToPlay(trackUrl: trackUrl)
            self.currentAudio += 1
        }
        else {
            self.currentAudio = 0
            self.audioNameLabel.text = self.audioArray[0].name
            self.imageView.image = self.audioArray[0].image
            guard let trackUrl = self.audioArray[0].url else {return}
            self.prepareAudioToPlay(trackUrl: trackUrl)
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

//MARK: - AVAudioPlayerDelegate
extension AudioPlayerViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNext()
    }
}
