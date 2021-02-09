//
//  FriendsTableViewCell.swift
//  less_1_IOS
//
//  Created by elf on 09.02.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet var AvatarImage: UIImageView!
    
    @IBOutlet var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
