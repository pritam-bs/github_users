//
//  UserDetailsCacheUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 14.07.2024.
//

import Foundation

protocol UserDetailsCacheUseCase {
    func saveToCache(entity: UserDetailsEntity, forKey key: UserDetailsCacheKey)
    func fetchFromCache(forKey key: UserDetailsCacheKey) -> UserDetailsEntity?
}
