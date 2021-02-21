//
//  NewsTableViewCell.swift
//  less_1_IOS
//
//  Created by elf on 19.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var NewsTitleLabel: UILabel!
    

    @IBOutlet weak var NewLikeButton: UIButton!
   
    @IBOutlet weak var NewsImageView: UIImageView!

    @IBOutlet weak var cntViewsLbl: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var likes = 1
    
    @IBAction func likesBtn_Click(_ sender: UIButton) {
        if self.NewLikeButton.tag == 0 {
            self.NewLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.NewLikeButton.tag = 1
            self.likes += 1
            self.NewLikeButton.setTitle("\(likes)", for: .normal)
        } else {
            self.NewLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.NewLikeButton.tag = 0
            self.likes -= 1
            self.NewLikeButton.setTitle("\(likes)", for: .normal)
        }
        
        UIView.transition(
            with: self.NewLikeButton,
            duration: 0.4,
            options: .transitionFlipFromBottom,
            animations: {
                self.NewLikeButton.setTitle("\(self.likes)", for: .normal)
            }
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
