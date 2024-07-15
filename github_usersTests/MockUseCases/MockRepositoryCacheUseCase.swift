//
//  MockRepositoryCacheUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Foundation
@testable import github_users

class MockRepositoryCacheUseCase: RepositoryCacheUseCase {
    var cachedRepositories: [RepositoryEntity]?

    func fetchFromCache(forKey key: RepositoryCacheKey) -> [RepositoryEntity]? {
        return cachedRepositories
    }
    
    func saveToCache(entity: [RepositoryEntity], forKey key: RepositoryCacheKey) {
        cachedRepositories = entity
    }
}
