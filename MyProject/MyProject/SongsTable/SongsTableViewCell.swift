//
//  SongsTableViewCell.swift
//  MyProject
//
//  Created by Elena Alekseeva on 5/21/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SongsTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
//        count += 1
//        if count > 2 {count = 1}
//        switch  count {
//        case 1:
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        case 2:
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//        default:
//            break
//        }
    }
}
