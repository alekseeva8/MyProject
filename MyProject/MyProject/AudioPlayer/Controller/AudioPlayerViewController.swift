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
    
    private var audioPlayer = AVAudioPlayer()
    private var timer: Timer?
    var audioNumber = 0
    var audioArray: [Audio] = []
    
    @IBOutlet weak var reverseView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var audioNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        let currentAudio = audioArray[audioNumber]
        imageView.image = currentAudio.image
        audioNameLabel.text = currentAudio.name
        
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
        
        guard let trackUrl = currentAudio.url else {return}
        prepareAudioToPlay(trackUrl: trackUrl)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // stop timer when view disappear
        timer?.invalidate()
    }
    
    @IBAction func homeButtonTapped(_ sender: UIBarButtonItem) {
        let router = Router(presentor: self)
        router.returnToMainScreen()
    }
    
    //MARK: - Functions
    //setting up background views of buttons
    private func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }
    
    //MARK: - prepareAudioToPlay()
    // get url for AudioPlayer
    // if audio has already been downloaded and saved to file system - get newDirectoryURL
    // if it hasn't - audio is downloading from network and tmpDirectoryURL is being passed. (finally, audio is being saved to file system)
    private func prepareAudioToPlay(trackUrl: URL) {
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
    
    private func startAnimation(of sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    private func stopAnimation(of sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }
    
    //MARK: - playPauseButtonTouchedDown()
    @IBAction func playPauseButtonTouchedDown(_ sender: UIButton) {
        startAnimation(of: sender)

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
        stopAnimation(of: sender)
    }
    
    //MARK: - prevButtonTouchedDown()
    @IBAction func prevButtonTouchedDown(_ sender: UIButton) {
        startAnimation(of: sender)
        playPrevious()
    }
    
    @IBAction func prevButtonTouchedUpInside(_ sender: UIButton) {
        stopAnimation(of: sender)
    }
    
    func playPrevious() {
        
        switch audioNumber {
        case 0:
            guard let firstAudio = audioArray.first else {return}
            audioNameLabel.text = firstAudio.name
            imageView.image = firstAudio.image
            guard let trackUrl = firstAudio.url else {return}
            prepareAudioToPlay(trackUrl: trackUrl)
            audioPlayer.play()
        default:
            let previousAudio = audioArray[audioNumber - 1]
            audioNameLabel.text = previousAudio.name
            imageView.image = previousAudio.image
            guard let trackUrl = previousAudio.url else {return}
            prepareAudioToPlay(trackUrl: trackUrl)
            audioPlayer.play()
            audioNumber -= 1
        }
    }
    
    //MARK: - nextButtonTouchedDown()
    @IBAction func nextButtonTouchedDown(_ sender: UIButton) {
        startAnimation(of: sender)
        playNext()
    }
    
    @IBAction func nextButtonTouchedUpInside(_ sender: UIButton) {
        stopAnimation(of: sender)
    }
    
    func playNext() {
        if audioNumber < audioArray.count-1 {
            let nextAudio = audioArray[audioNumber + 1]
            guard let trackUrl = nextAudio.url else {return}
            prepareAudioToPlay(trackUrl: trackUrl)
            
            audioNameLabel.text = nextAudio.name
            imageView.image = nextAudio.image
            audioNumber += 1
        }
        else {
            audioNumber = 0
            guard let firstAudio = audioArray.first else {return}
            guard let trackUrl = firstAudio.url else {return}
            prepareAudioToPlay(trackUrl: trackUrl)
            
            audioNameLabel.text = firstAudio.name
            imageView.image = firstAudio.image
        }
    }
    
    //MARK: - timeSliderScrolled()
    @IBAction func timeSliderScrolled(_ sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(sender.value)
        audioPlayer.play()
    }
    
    @objc func updateTimeSlider() {
        timeSlider.value = Float(audioPlayer.currentTime)
    }
    
    //MARK: - volumeSliderScrolled()
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
