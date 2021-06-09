//
//  VKGroup.swift
//  VKAppClone
//
//  Created by elf on 10.05.2021.
//

import Foundation
import SwiftyJSON

class VKGroup {
    let id: Int
    private let photoUrlString: String
    let name: String
    let screenName: String
    
    
    var photoUrl: URL? { URL(string: photoUrlString) }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.photoUrlString = json["photo_100"].stringValue
        self.name = json["name"].stringValue
        self.screenName = json["screen_name"].stringValue
    }
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
