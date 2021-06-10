//
//  VKFriend.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift


class VKFriend : RealmSwift.Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrlString: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
//    var photos = List<VKPhoto>()
    
    var photoUrl: URL? { URL(string: photoUrlString) }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.photoUrlString = json["photo_100"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

struct VKFriendSection: Comparable {
    let title: Character
    var friends: [VKFriend]
    
    static func < (lhs: VKFriendSection, rhs: VKFriendSection) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: VKFriendSection, rhs: VKFriendSection) -> Bool {
        lhs.title == rhs.title
    }
}
