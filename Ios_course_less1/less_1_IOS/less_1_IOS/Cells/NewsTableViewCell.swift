//
//  NewsTableViewCell.swift
//  less_1_IOS
//
//  Created by elf on 19.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var NewsTitleLabel: UILabel!
    
    private var likes = false
    @IBOutlet var NewLikeButton: UIButton!
//    @IBAction func NewsLikeButton(_ sender: Any) {
//        if likes {
//            likes = false
//            self.NewLikeButton.imageView?.image = UIImage(systemName: "heart")
//        } else {
//            self.NewLikeButton.imageView?.image = UIImage(systemName: "heart.fill")
//            likes = true
//        }
//    }
    @IBAction func NewsSendToButton(_ sender: Any) {
    }
    
    @IBAction func NewsCommentsButton(_ sender: Any) {
    }
    @IBOutlet var NewsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
