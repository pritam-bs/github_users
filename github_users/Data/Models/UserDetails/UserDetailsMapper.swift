//
//  UserDetailsMapper.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct UserDetailsMapper {
    static func map(dto: UserDetailsDTO) -> UserDetailsEntity {
        return UserDetailsEntity(
            avatarURL: dto.avatarURL,
            username: dto.login,
            fullName: dto.name,
            followers: dto.followers,
            followings: dto.following
        )
    }
}
