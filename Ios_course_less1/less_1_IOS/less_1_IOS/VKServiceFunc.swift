//
//  VKServiceFunc.swift
//  less_1_IOS
//
//  Created by elf on 19.04.2021.
//

//import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class VKServiceFunc {
    
    let baseVkUrl = "https://api.vk.com"
    private let accessToken: String
    
    
    var baseParams: Parameters {
        [
            "access_token": accessToken,
            "extended": 1,
            "v": "5.92"
        ]
    }
    
    init(token: String) {
        self.accessToken = token
    }
    
//    func loadGroups(completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
//        let path = "/method/groups.get"
//
//        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseData { response in
//            switch response.result {
//            case let .success(data):
//                do {
//                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
//                    let groups = groupsResponse.response.items
//                    completionHandler(.success(groups))
//                } catch {
//                    completionHandler(.failure(error))
//                }
//            case let .failure(error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
    
    func loadFriends(completionHandler: @escaping ((Result<[VKFriend], Error>) -> Void)) {
        let path = "/method/friends.get"
        
//        fields список дополнительных полей, которые необходимо вернуть.
//        Доступные значения: nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities
        var params = baseParams
        params["fields"] = [ "photo_100" ]
        
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                //            {
                //              "response" : {
                //                "count" : 322,
                //                "items" : [
                //                  {
                //                    "id" : 6949,
                let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
                let friends = friendsJSONArray.map(VKFriend.init)
                print("first friend \(friends[0])")
                completionHandler(.success(friends))
            }
        }
    }
    
//    func searchGroup(group: String, completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
//        let path = "/method/groups.search"
//        var params = baseParams
//        params["q"] = group
//
//        print("group \(group)")
//
//        AF.request(baseVkUrl + path, method: .get, parameters: params).responseData { response in
//            switch response.result {
//            case let .success(data):
//                do {
//                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
//                    let groups = groupsResponse.response.items
//                    completionHandler(.success(groups))
//                } catch {
//                    completionHandler(.failure(error))
//                }
//            case let .failure(error):
//                completionHandler(.failure(error))
//            }
//        }
//   }
//
    func loadPics(token: String) {
        //photos.getUserPhotos
        let path = "/method/photos.getUserPhotos"
        
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseJSON { response in
            guard let json = response.value else { return }
            
            print("jsonPics \(json)")
        }
    }
}


