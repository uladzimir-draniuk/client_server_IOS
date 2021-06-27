//
//  NewsImageCell.swift
//  VKAppClone
//
//  Created by elf on 16.06.2021.
//

import UIKit
import Kingfisher

class NewsImageCell : UITableViewCell, AnyNewsCell {
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(200)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (with news: VKNews) {

        newsImageView.kf.setImage(with: news.url)
    }
}
