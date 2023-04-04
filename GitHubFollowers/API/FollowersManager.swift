//
//  FollowersManager.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation
import Alamofire

protocol FollowersManagerDelegate {
    func fetchFollowers(followers: [Follower])
    func fetchFollowing(following: [Follower])
}

struct FollowersManager {
    
   var delegate: FollowersManagerDelegate?
    
   func fetchFollowers(username: String) {
//        guard let url = URL(string: "https://api.github.com/users/\(username)/followers") else { return }
        
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching followers = \(error)")
//                return
//            }
//            if let data = data {
//                self.parseJSONa(data: data, followers: true)
//            }
//        }
//        task.resume()
       
       AF.request("https://api.github.com/users/\(username)/followers").response { response in
           guard let data = response.data else { return }
           parseJSONa(data: data, followers: true)
       }
    }
    
    func parseJSONa(data: Foundation.Data, followers: Bool) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([Follower].self, from: data)
            DispatchQueue.main.async {
                if followers {
                    self.delegate?.fetchFollowers(followers: decodedData)
                } else {
                    self.delegate?.fetchFollowing(following: decodedData)
                }
            }
        } catch {
            print("Error parsing JSON for followers or following - \(error)")
        }
    }
    
    func fetcFollowing(username: String) {
//         guard let url = URL(string: "https://api.github.com/users/\(username)/following") else { return }
//
//         let session = URLSession(configuration: .default)
//         let task = session.dataTask(with: url) { data, response, error in
//             if let error = error {
//                 print("Error fetching followers = \(error)")
//                 return
//             }
//             if let data = data {
//                 self.parseJSONa(data: data, followers: false)
//             }
//         }
//         task.resume()
        
        AF.request("https://api.github.com/users/\(username)/following").response { response in
            guard let data = response.data else { return }
            
            parseJSONa(data: data, followers: false)
        }
     }
}
