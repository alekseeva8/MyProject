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

    //let songName = SongsManager.shared.songName
    var songNumber = SongsManager.shared.songNumber
    let songsArray = DataSourceForSongsTable().songsArray

    @IBOutlet weak var reverseView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var forwardView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

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

        let song = songsArray[songNumber]
        audioNameLabel.text = song.name
        imageView.image = song.image
        prepareToPlay(song: song.name)
    }

    //MARK: - Functions
    //setting up background views of buttons
    func setBackgroundView(_ backgroundView: UIView) {
        backgroundView.layer.cornerRadius = backgroundView.bounds.width/2
        backgroundView.clipsToBounds = true
    }

    //MARK: - AVAudioPlayer prepareToPlay()
    func prepareToPlay(song: String) {
        //ищем путь к файлу
        guard let path = Bundle.main.path(forResource: song, ofType: "mp3") else {return}
        //получаем url файла
        let url = URL(fileURLWithPath: path)
        //воспроизводим содержимое файла
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            timeSlider.maximumValue = Float(audioPlayer.duration)
        } catch let error {
            print(error)
        }
        //audioPlayer = AVPlayer(url: url)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
    }

    //MARK: - playPauseButton
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

    //MARK: - PrevButton; NextButton
    @IBAction func touchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

            //действия для PREV
            if sender == self.prevButton {
                if self.audioPlayer.isPlaying {
                    if self.songNumber == 0 {
                        self.audioNameLabel.text = self.songsArray[0].name
                        self.imageView.image = self.songsArray[0].image
                        self.prepareToPlay(song: self.songsArray[0].name)
                        self.audioPlayer.play()
                    }
                else {
                        let previousSongNumber = self.songNumber - 1
                        self.audioNameLabel.text = self.songsArray[previousSongNumber].name
                        self.imageView.image = self.songsArray[previousSongNumber].image
                        let previousSong = self.songsArray[previousSongNumber]
                        self.prepareToPlay(song: previousSong.name)
                        self.audioPlayer.play()
                        self.songNumber -= 1
                }
            }
            }

            //действия для NEXT
            if sender == self.nextButton {
                if self.audioPlayer.isPlaying {
                    if self.songNumber < self.songsArray.count-1 {
                        let nextSongNumber = self.songNumber + 1
                        self.audioNameLabel.text = self.songsArray[nextSongNumber].name
                        self.imageView.image = self.songsArray[nextSongNumber].image
                        let nextSong = self.songsArray[nextSongNumber]
                        self.prepareToPlay(song: nextSong.name)
                        self.audioPlayer.play()
                        self.songNumber += 1
                    }
                    else {
                        self.songNumber = 0
                        self.audioNameLabel.text = self.songsArray[0].name
                        self.imageView.image = self.songsArray[0].image
                        self.prepareToPlay(song: self.songsArray[0].name)
                        self.audioPlayer.play()
                    }
                }
            }
        }
    }

    @IBAction func touchedUpInside(_ sender: UIButton) {
        sender.transform = CGAffineTransform.identity
    }

    //НЕУДАЧНЫЙ ЖЕСТ - ПРОБОВАТЬ ЗАМЕНИТЬ
    //ДОРОЖКУ ОТОБРАЖАТЬ
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
        //print("audioPlayerDidFinishPlaying")
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
    }
}
