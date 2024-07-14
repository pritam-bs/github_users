//
//  UserMapper.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct UserMapper {
    static func map(dto: UserDTO) -> UserEntity {
        return UserEntity(
            login: dto.login,
            id: dto.id,
            avatarURL: dto.avatarURL
        )
    }

    static func map(dto: UsersDTO) -> UsersEntity {
        return dto.map { map(dto: $0) }
    }
}
