//
//  ChannelCell.swift
//  smack
//
//  Created by Ricardo Herrera Petit on 8/16/17.
//  Copyright © 2017 Ricardo Herrera Petit. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //Outlet
    
    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel:Channel) {
        let title = channel.name ?? ""
        channelName.text = "#\(title)"
    }
    
}
