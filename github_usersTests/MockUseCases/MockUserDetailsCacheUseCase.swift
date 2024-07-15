//
//  MockUserDetailsCacheUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Foundation
@testable import github_users

class MockUserDetailsCacheUseCase: UserDetailsCacheUseCase {
    var cachedUserDetails: UserDetailsEntity?

    func fetchFromCache(forKey key: UserDetailsCacheKey) -> UserDetailsEntity? {
        return cachedUserDetails
    }
    
    func saveToCache(entity: UserDetailsEntity, forKey key: UserDetailsCacheKey) {
        cachedUserDetails = entity
    }
}
