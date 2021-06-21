//
//  FriendTableViewCell.swift
//  less_1_IOS
//
//  Created by elf on 09.02.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet var avatarView: AvatarView!
    
    @IBOutlet var friendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
