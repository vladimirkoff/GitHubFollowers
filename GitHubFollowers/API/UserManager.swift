//
//  UserManager.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation
import Alamofire

protocol UserManagerDelegate {
    func fetchUser(user: User)
}

struct UserManager {
    
   static var delegate: UserManagerDelegate?
     
  static func fetchUser(username: String) {
         guard let url = URL(string: "https://api.github.com/users/\(username)") else { return }
        
        // URLSession
         
//         let session = URLSession(configuration: .default)
//         let task = session.dataTask(with: url) { data, response, error in
//             if let error = error {
//                 print("Error fetching followers = \(error)")
//                 return
//             }
//             if let data = data {
//                 parseJSONa(data: data)
//             }
//         }
//         task.resume()
        
        // Alamofire
        
        AF.request("https://api.github.com/users/\(username)").response { response in
            guard let data = response.data else { return }
            parseJSONa(data: data)
        }
    }
     
  static func parseJSONa(data: Foundation.Data) {
         let decoder = JSONDecoder()
         
         do {
             let decodedData = try decoder.decode(User.self, from: data)
             DispatchQueue.main.async {
                 self.delegate?.fetchUser(user: decodedData)
             }
         } catch {
             print("Error parsing JSON user")
         }
     }
}
