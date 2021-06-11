//
//  VKGroup.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//


import UIKit
import RealmSwift

class VKGroup : RealmSwift.Object, Codable {
    
    @objc dynamic var groupId: Int = 0
    @objc dynamic private var photoUrlString: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""

    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decode(Int.self, forKey: .groupId)
        name = try container.decode(String.self, forKey: .name)
        photoUrlString = try container.decode(String.self, forKey: .photoUrlString)
        screenName = try container.decode(String.self, forKey: .screenName)
    }
    
    var photoUrl: URL? { URL(string: photoUrlString) }
    
    
    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case name
        case photoUrlString = "photo_200"
        case screenName = "screen_name"
    }
    
    override class func primaryKey() -> String? {
        return "groupId"
    }
}



struct GroupResponse: Codable {
    let response: GroupContainer
}

struct GroupContainer: Codable {
    let items: [VKGroup]
}

struct GroupSection: Comparable {
    let title: Character
    let groups: [VKGroup]
    
    static func < (lhs: GroupSection, rhs: GroupSection) -> Bool {
        lhs.title < rhs.title
    }
}

struct GroupPic: Equatable {
    let name: String
    let date: Date
    let pic: UIImage
}

/*
{
"response": {
"count": 12,
"items": [{
"id": 184747934,
"name": "Z пицца Брест",
"screen_name": "z_pizza_brest",
"is_closed": 0,
"type": "group",
"is_admin": 0,
"is_member": 1,
"is_advertiser": 0,
"photo_50": "https://sun1.belt...6,821,821&ava=1",
"photo_100": "https://sun1.belt...6,821,821&ava=1",
"photo_200": "https://sun1.belt...6,821,821&ava=1"
}, {
"id": 183453272,
"name": "СамоСтрой",
"screen_name": "stroivsesam",
"is_closed": 0,
"type": "page",
"is_admin": 0,
"is_member": 1,
"is_advertiser": 0,
"photo_50": "https://sun2.belt...1,806,806&ava=1",
"photo_100": "https://sun2.belt...1,806,806&ava=1",
"photo_200": "https://sun2.belt...1,806,806&ava=1"
},
*/
