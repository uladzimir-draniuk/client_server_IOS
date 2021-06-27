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
                do {
                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
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
                do {
                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadPics(owner: Int, completionHandler: @escaping ((Result<[VKPhoto], Error>) -> Void)) {
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
                let photosJSONArray = JSON(json)["response"]["items"].arrayValue
                let photosFriend = photosJSONArray.map(VKPhoto.init)
                completionHandler(.success(photosFriend))
            }
        }
    }
    
    func loadNews(completionHandler: @escaping ((Result<[VKNews], Error>) -> Void)) {
        let path = "/method/newsfeed.get"
        
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                
                let dispatchGroup = DispatchGroup()
                
                var posts: [VKNews] = []
                var friends: [VKFriend] = []
                var groupsJsonArray: [JSON] = []
                var groups: [VKGroup] = []

                DispatchQueue.global().async(group: dispatchGroup) {
                    let postsJsonArray = JSON(json)["response"]["items"].arrayValue
                    posts = postsJsonArray.map(VKNews.init)
                }
                DispatchQueue.global().async(group: dispatchGroup) {
                    let friendsJsonArray = JSON(json)["response"]["profiles"].arrayValue
                    friends = friendsJsonArray.map { VKFriend(json: $0 ) }
                }
                DispatchQueue.global().async(group: dispatchGroup) {
                    groupsJsonArray = JSON(json)["response"]["groups"].arrayValue
                    groupsJsonArray.forEach { group in
                        var newGroup = VKGroup()
                        newGroup.groupId = group["id"].intValue
                        newGroup.photoUrlString = group["photo_200"].stringValue
                        newGroup.name = group["name"].stringValue
                        newGroup.screenName = group["screen_name"].stringValue
                        groups.append(newGroup)
                    }
                    
                    
                    //                    13 elements
                    //                      ▿ 0 : {
                    //                      "type" : "page",
                    //                      "is_admin" : 0,
                    //                      "photo_50" : "https:\/\/sun1.beltelecom-by-minsk.userapi.com\/s\/v1\/if1\/YpHH09EUv4LS7st5vXJ74AAiBMvXj0Dk2FFl66W4afhStRW69phQwu9i7QyucWXvoLPxinV0.jpg?size=50x0&quality=96&crop=46,46,208,208&ava=1",
                    //                      "photo_200" : "https:\/\/sun1.beltelecom-by-minsk.userapi.com\/s\/v1\/if1\/0k9GW_oN0WKquu2dj7Q64Gr5GBVSJ2XaucwIkCfOroCfH1XTtVo2SXeG7mifJh0QVNxnAolq.jpg?size=200x0&quality=96&crop=46,46,208,208&ava=1",
                    //                      "photo_100" : "https:\/\/sun1.beltelecom-by-minsk.userapi.com\/s\/v1\/if1\/6bdu1RsdO_ZZXPCaAHwdvYHf90rbRN7F2kB5tT_RV2W7hhffol_5NDFsVw3iSbjkXskDFTdQ.jpg?size=100x0&quality=96&crop=46,46,208,208&ava=1",
                    //                      "is_closed" : 0,
                    //                      "is_advertiser" : 0,
                    //                      "name" : "Уроки английского",
                    //                      "id" : 38847637,
                    //                      "screen_name" : "lesson.english",
                    //                      "is_member" : 1
                }

                
                dispatchGroup.notify(queue: DispatchQueue.global()) {
                    
                    let newsWithSource = posts.compactMap { news -> VKNews? in
                        if news.authorId > 0 {
                            var newsCopy = news
                            guard let newsAuthor = friends.first(where: {$0.id == news.authorId}) else { return nil}
                            newsCopy.source = newsAuthor
                            return newsCopy
                        } else {
                            var newsGroupCopy = news
                            guard let newsAuthor = groups.first(where: { $0.groupId == -(news.authorId)}) else {return nil}
                            newsGroupCopy.source = newsAuthor
                             
//                            print("something TODO group parsing")
                            return newsGroupCopy
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(.success(newsWithSource))
                    }
                }
            }
        }
    }
}
