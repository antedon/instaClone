//
//  FeedCell.swift
//  instaCloneApp
//
//  Created by Yaşar Bayındır on 22.04.2020.
//  Copyright © 2020 Yaşar Bayındır. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
    }
}
