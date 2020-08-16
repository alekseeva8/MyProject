//
//  Router.swift
//  MyProject
//
//  Created by Elena Alekseeva on 8/16/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//


import UIKit

struct Router {
    
    var presentor: UIViewController
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func setInitialScreen() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let isSigned = UserDefaults.standard.value(forKey: "signed") as? Bool
        var initialVC = UIViewController()
        
        switch isSigned {
        case true: 
            initialVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC")
        default: 
            initialVC = storyboard.instantiateViewController(withIdentifier: "SignupVC")
        }
        return initialVC
    }
    
    func showLoginScreen() {
        let loginVC = storyboard.instantiateViewController(identifier: "loginVC")
        loginVC.modalPresentationStyle = .fullScreen
        presentor.present(loginVC, animated: true, completion: nil)
    }
    
    func showMainScreen() {
        UserDefaults.standard.set(true, forKey: "signed")
        let navigationVC = storyboard.instantiateViewController(identifier: "NavigationVC")
        navigationVC.modalPresentationStyle = .fullScreen
        presentor.present(navigationVC, animated: true, completion: nil)
    }
    
    func showSongsScreen() {
        let songsVC = storyboard.instantiateViewController(identifier: "songsVC")
        presentor.navigationController?.pushViewController(songsVC, animated: true)
    }
    
    func showStoriesScreen() {
        let storiesVC = storyboard.instantiateViewController(identifier: "storiesVC")
        presentor.navigationController?.pushViewController(storiesVC, animated: true)
    }
    
    func showVideoScreen() {
        let videoVC = storyboard.instantiateViewController(identifier: "videoVC")
        presentor.navigationController?.pushViewController(videoVC, animated: true)
    }
    
    func showPlayerScreen(with audio: [Audio], audioNumber: Int) {
        guard let playerVC = storyboard.instantiateViewController(identifier: "playerVC") as? AudioPlayerViewController else { return }
        playerVC.audioArray = audio
        playerVC.audioNumber = audioNumber
        presentor.navigationController?.pushViewController(playerVC, animated: true)
    }
    
    func showFavoritesScreen(with favorites: [Audio]) {
        guard let favoritesVC = storyboard.instantiateViewController(identifier: "favoritesVC") as? FavoritesViewController else { return }
        favoritesVC.favorites = favorites
        presentor.navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    func returnToMainScreen() {
        presentor.navigationController?.popToRootViewController(animated: true)
    }
}
