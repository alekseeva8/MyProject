//
//  LocalAssetsHandler.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/7/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import  UIKit

class LocalAssetsHandler {
    
    static func getAssets() -> [Audio] {
        var assets: [Audio] = []
        
        //getting url to all of the files (to directory)
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath ?? "")
        //getting access to all of the files. All files will be stored in urlsArray
        do {
            //Performs a shallow search of the specified directory, returns URLs for the contained items.
            let urlsArray = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            urlsArray.forEach { (url) in
                let urlString = url.absoluteString
                if urlString.contains(".mp3") {
                    let urlStringSplitted = urlString.split(separator: "/")
                    
                    var assetName = String(urlStringSplitted.last ?? "")
                    assetName = assetName.replacingOccurrences(of: ".mp3", with: "")
                    assetName = assetName.replacingOccurrences(of: "%20", with: " ")
                    guard let path = Bundle.main.path(forResource: assetName, ofType: "mp3") else {return}
                    let url = URL(fileURLWithPath: path)
                    assets.append(Audio(name: assetName, image: UIImage(named: assetName) ?? UIImage(), url: url, kind: "song", isFavorite: false))
                }
            }
        } catch {
            print(error)
        }
        return assets
    }
}

