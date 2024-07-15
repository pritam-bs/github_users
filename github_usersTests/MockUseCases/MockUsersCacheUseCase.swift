//
//  MockUsersCacheUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class MockUsersCacheUseCase: UsersCacheUseCase {
    var cache: [UsersCacheKey: UsersEntity] = [:]
    
    func fetchFromCache(forKey key: UsersCacheKey) -> UsersEntity? {
        return cache[key]
    }
    
    func saveToCache(entity: UsersEntity, forKey key: UsersCacheKey) {
        cache[key] = entity
    }
}
