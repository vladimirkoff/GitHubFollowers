//
//  UserService.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation
//import FirebaseAuth

struct UserService {

    static func checkIfUsernameValid(username: String, completion: @escaping(Bool) -> ()) {
        guard let url = URL(string: "https://api.github.com/users/vladimirkoff") else { return }
        var isValid = true
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error cheching validation")
            }
            
            if let data = data {
                isValid = self.parseJSON(data: data)
                DispatchQueue.main.async {
                    completion(isValid)
                }
                
            }
            
        }
        task.resume()
    }
    
    static func parseJSON(data: Foundation.Data) -> Bool {
        let decoder = JSONDecoder()
        var isValid = true
        do {
            let decodedData = try decoder.decode(Follower.self, from: data)
        } catch {
            isValid = false
        }
        return isValid
    }
}