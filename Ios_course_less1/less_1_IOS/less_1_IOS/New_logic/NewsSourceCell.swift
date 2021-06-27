//
//  NewsSourceCell.swift
//  VKAppClone
//
//  Created by elf on 16.06.2021.
//

import UIKit

class NewsSourceCell : UITableViewCell, AnyNewsCell {
    private let newsAuthorImageView = UIImageView()
    private let newsAuthorName = UILabel()
    private let newsDataText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsAuthorImageView)
        contentView.addSubview(newsAuthorName)
        contentView.addSubview(newsDataText)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        newsAuthorImageView.snp.makeConstraints { make in
            make.width.equalTo(newsAuthorImageView.snp.height)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        newsAuthorName.snp.makeConstraints { make in
            make.centerY.equalTo(newsAuthorImageView)
            make.leading.equalTo(newsAuthorImageView.snp.trailing).offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure (with news: VKNews) {
        if let newsSource = news.source {
            newsAuthorImageView.kf.setImage(with: newsSource.imageUrl)
            newsAuthorName.text = newsSource.name
        } else {
            newsAuthorImageView.image = UIImage(named: "group_2")
            newsAuthorName.text = String(news.authorId)
        }
    }
}
