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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
