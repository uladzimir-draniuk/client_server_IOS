//
//  NewsTextCell.swift
//  VKAppClone
//
//  Created by elf on 16.06.2021.
//

import UIKit

class NewsTextCell : UITableViewCell, AnyNewsCell {
    private let newsTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTextLabel)
        newsTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (with news: VKNews) {
        newsTextLabel.text = news.name
    }
}
