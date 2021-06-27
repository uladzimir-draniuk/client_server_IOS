//
//  NewsOtherInfoCell.swift
//  VKAppClone
//
//  Created by elf on 16.06.2021.
//

import UIKit
import SnapKit

class NewsOtherInfoCell : UITableViewCell, AnyNewsCell {
    private let newsLikesImageView = UIImageView()
    private let newsLikesCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsLikesImageView)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (with news: VKNews) {
        
    }
}
