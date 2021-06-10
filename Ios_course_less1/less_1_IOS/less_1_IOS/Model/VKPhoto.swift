//
//  VKPhoto.swift
//  less_1_IOS
//
//  Created by elf on 20.04.2021.
//

import Foundation
import UIKit
import SwiftyJSON
import RealmSwift


class VKPhoto : RealmSwift.Object {
    @objc dynamic var photoId: Int = 0
    @objc dynamic var ownerId: Int = 0
    var photosSize = List<VKPhotoSizes>()
    @objc dynamic var count : Int = 0

//    var friend = LinkingObjects (fromType: VKPhoto.self, property: "photos")
    
    convenience init(json: JSON) {
        self.init()
        self.photoId = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
    }
    
    override class func primaryKey() -> String? {
        return "photoId"
    }
}

class VKPhotoSizes : RealmSwift.Object {
    @objc dynamic var photoSizeId = UUID().uuidString
    @objc dynamic var type: String = ""
    @objc dynamic var photoUrlString : String = ""
    
   
    var photoSize = LinkingObjects (fromType: VKPhoto.self, property: "photoSizes")
    var photoUrl: URL? { URL(string: photoUrlString) }
    
    convenience init(json: JSON) {
        self.init()
        self.type = json["type"].stringValue
        self.photoUrlString = json["url"].stringValue
    }
    
    override class func primaryKey() -> String? {
        return "photoSizeId"
    }
}

