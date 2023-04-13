//
//  UserService.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation
import Alamofire

struct UserService {

    static func checkIfUsernameValid(username: String, completion: @escaping(Bool) -> ()) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else { return }
        var isValid = true
        
        // URLSession
        
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error cheching validation - \(error.localizedDescription)")
//            }
//
//            if let data = data {
//                isValid = self.parseJSON(data: data)
//                DispatchQueue.main.async {
//                    completion(isValid)
//                }
//            }
//        }
//        task.resume()
        
        //Alamofire
        
        AF.request("https://api.github.com/users/\(username)").response { response in
            guard let data = response.data else { return }
            isValid = self.parseJSON(data: data)
            DispatchQueue.main.async {
                completion(isValid)
            }
        }
        
        
    }
    
    static func parseJSON(data: Foundation.Data) -> Bool {
        let decoder = JSONDecoder()
        var isValid = true
        do {
            try decoder.decode(Follower.self, from: data)
        } catch {
            isValid = false
        }
        return isValid
    }
}
