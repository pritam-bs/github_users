//
//  UserMapper.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct UserMapper {
    static func map(dto: UserDTO) -> User {
        return User(
            login: dto.login,
            id: dto.id,
            avatarURL: dto.avatarURL
        )
    }

    static func map(dto: UsersDTO) -> Users {
        return dto.map { map(dto: $0) }
    }
}
