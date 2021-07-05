//
//  VKNews.swift
//  VKAppClone
//
//  Created by elf on 21.06.2021.
//

import Foundation
import UIKit
import SwiftyJSON

protocol NewsSource {
    var name: String { get }
    var imageUrlString: String { get }
}

extension NewsSource {
    var imageUrl : URL? { URL(string: imageUrlString) }
}

class VKNews {
    var imageUrlString: String?
    var authorId: Int
    let name: String
    let isLiked: Bool
    let date : Date
    
    var source: NewsSource?
    
    var url: URL? { imageUrlString.flatMap { URL(string: $0)} }
    
    init (json: JSON) {
        self.name = json["text"].stringValue
        self.imageUrlString = json["attachments"].arrayValue.first(where: { $0["type"] == "photo"})?["photo"]["sizes"].arrayValue.last?["url"].stringValue
        self.isLiked = json["is_favorite"].boolValue
        self.authorId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
    }
}
