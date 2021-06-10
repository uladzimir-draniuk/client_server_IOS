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
        
        var params = baseParams
        params["fields"] = [ "photo_100" ]
        
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
                let friends = friendsJSONArray.map(VKFriend.init)
//                print("first friend \(friends[0])")
                completionHandler(.success(friends))
            }
        }
    }
    
    func loadGroup(completionHandler: @escaping ((Result<[VKGroup], Error>) -> Void)) {
        let path = "/method/groups.get"
        let params = baseParams
 
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
//                let count = JSON(data)["response"]["count"].intValue
                let groupArray = JSON(data)["response"]["items"].arrayValue
                let groups = groupArray.map(VKGroup.init)
//                print("first group \(groupArray[0])")
                completionHandler(.success(groups))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }

    
    func searchGroup(group: String, completionHandler: @escaping ((Result<[VKGroup], Error>) -> Void)) {
        let path = "/method/groups.search"
        var params = baseParams
        params["q"] = group
 
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
//                let count = JSON(data)["response"]["count"].intValue
                let groupArray = JSON(data)["response"]["items"].arrayValue
                let groups = groupArray.map(VKGroup.init)
                completionHandler(.success(groups))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadPics(owner: Int, completionHandler: @escaping ((Result<[VKPhoto], Error>) -> Void)) {
        //photos.getUserPhotos
        let path = "/method/photos.get"
        var photoParams = baseParams
        photoParams["extended"] = 0
        photoParams["owner_id"] = owner
        photoParams["album_id"] = "wall"
        photoParams["photo_sizes"] = 1
        
        
        AF.request(baseVkUrl + path, method: .get, parameters: photoParams).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                var count = JSON(json)["response"]["count"].intValue
                let photosJSONArray = JSON(json)["response"]["items"].arrayValue
                let photosFriend = photosJSONArray.map(VKPhoto.init)
                if count > 50 {
                    count = 50
                }
                for index in 0..<count {
                    let photoSizeJSONArray = JSON(json)["response"]["items"][index]["sizes"].arrayValue
                    let photoSizeArray = photoSizeJSONArray.map(VKPhotoSizes.init)
                    photosFriend[index].photos = photoSizeArray
                    photosFriend[index].count = count
                    
                }
                completionHandler(.success(photosFriend))
            }
        }
    }
}
