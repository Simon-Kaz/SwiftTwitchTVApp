//
//  CustomTableViewCell.swift
//  TwitchListing
//
//  Created by Szymon Kazmierczak on 28/05/2017.
//  Copyright © 2017 Szymon Kazmierczak. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var gameImageView: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameChannelsCount: UILabel!
    @IBOutlet var gameViewersCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
