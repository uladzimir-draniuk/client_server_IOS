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

