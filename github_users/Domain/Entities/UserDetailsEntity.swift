//
//  UserDetailsEntity.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct UserDetailsEntity: Codable {
    var avatarURL: String
    var username: String
    var fullName: String?
    var followers: Int
    var followings: Int
}
