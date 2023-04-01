//
//  User.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation

struct User: Codable {
    let login: String
    let followers: Int
    let following: Int
    let avatar_url: String
}
