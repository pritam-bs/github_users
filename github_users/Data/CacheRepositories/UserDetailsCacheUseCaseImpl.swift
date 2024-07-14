//
//  UserDetailsCacheUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

class UserDetailsCacheUseCaseImpl<CacheCodableManagerType: CacheCodableManagerProtocol>: UserDetailsCacheUseCase
where CacheCodableManagerType.KeyType == UserDetailsCacheKey,
      CacheCodableManagerType.DataType == UserDetailsEntity {
    
    private let cacheManager: CacheCodableManagerType
    
    init(cacheManager: CacheCodableManagerType) {
        self.cacheManager = cacheManager
    }
    
    func saveToCache(entity: UserDetailsEntity, forKey key: UserDetailsCacheKey) {
        cacheManager.save(entity: entity, forKey: key)
    }
    
    func fetchFromCache(forKey key: UserDetailsCacheKey) -> UserDetailsEntity? {
        return cacheManager.fetch(forKey: key)
    }
}
