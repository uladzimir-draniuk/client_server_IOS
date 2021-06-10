//
//  VKFriend.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

//{
//  "response" : {
//    "count" : 322,
//    "items" : [
//      {
//        "id" : 6949,
//        "deactivated" : "deleted",
//        "photo_100" : "https:\/\/vk.com\/images\/deactivated_100.png",
//        "track_code" : "ad6c086aFta1Uqg77G4Fqx9cxlIPqn-uHUte-kvJ4DqrKFZ2QJV7veprnT3tag_PcsVTgeDdbcg",
//        "first_name" : "Александр",
//        "last_name" : "Мишенин"
//      },
//      {
//        "id" : 14403,
//        "photo_100" : "https:\/\/sun1-29.userapi.com\/s\/v1\/if1\/f2EK3X_wP8JcqHanigdypv7YWfPgb6jeJTGujtg5LqGU6zm9ZR7DK3Xj9_Z4aOBes2L8iwh4.jpg?size=100x0&quality=96&crop=0,251,1538,1538&ava=1",
//        "track_code" : "27bf8006syEhdFQHYTS7IM4mKOwo_VHQ1L36oB-FhTz70Oa8_tveSnIXaAZjML1wybOuJsmdMbam",
//        "last_name" : "Zak",
//        "can_access_closed" : true,
//        "is_closed" : false,
//        "first_name" : "Dmitry"
//      },

//class VKFriend {
//    let id: Int
//    private let photoUrlString: String
//    let firstName: String
//    let lastName: String
//
//    var photoUrl: URL? { URL(string: photoUrlString) }
//
//    init(json: JSON) {
//        self.id = json["id"].intValue
//        self.photoUrlString = json["photo_100"].stringValue
//        self.firstName = json["first_name"].stringValue
//        self.lastName = json["last_name"].stringValue
//    }
//}
class VKFriend : RealmSwift.Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrlString: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
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
