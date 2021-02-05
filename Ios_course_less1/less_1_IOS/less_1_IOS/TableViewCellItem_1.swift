//
//  TableViewCellItem_1.swift
//  less_1_IOS
//
//  Created by elf on 06.02.2021.
//

import UIKit

class TableViewCellItem_1: UITableViewCell {

    @IBOutlet weak var LabelItem_1: UILabel! {
        didSet{
            LabelItem_1.text = "Иванов"
        }
    }
    @IBOutlet weak var item1_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
