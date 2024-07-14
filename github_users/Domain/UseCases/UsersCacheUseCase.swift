//
//  UsersCacheUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 14.07.2024.
//

import Foundation

protocol UsersCacheUseCase {
    func saveToCache(entity: UsersEntity, forKey key: UsersCacheKey)
    func fetchFromCache(forKey key: UsersCacheKey) -> UsersEntity?
}
