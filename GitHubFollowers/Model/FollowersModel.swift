//
//  FollowersModel.swift
//  GitHubFollowers
//
//  Created by Vladimir Kovalev on 31.03.2023.
//

import Foundation

struct Follower: Codable {
    let login: String
    let avatar_url: String
}
