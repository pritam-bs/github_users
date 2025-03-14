//
//  UserEntity.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct UserEntity: Codable, Identifiable, Hashable {
    let login: String
    let id: Int
    let avatarURL: String?
}

typealias UsersEntity = [UserEntity]
