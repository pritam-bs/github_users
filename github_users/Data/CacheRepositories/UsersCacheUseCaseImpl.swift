//
//  UsersCacheUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

class UsersCacheUseCaseImpl<CacheCodableManagerType: CacheCodableManagerProtocol>: UsersCacheUseCase
where CacheCodableManagerType.KeyType == UsersCacheKey,
      CacheCodableManagerType.DataType == UsersEntity {
    
    private let cacheManager: CacheCodableManagerType
    
    init(cacheManager: CacheCodableManagerType) {
        self.cacheManager = cacheManager
    }
    
    func saveToCache(entity: UsersEntity, forKey key: UsersCacheKey) {
        cacheManager.save(entity: entity, forKey: key)
    }
    
    func fetchFromCache(forKey key: UsersCacheKey) -> UsersEntity? {
        return cacheManager.fetch(forKey: key)
    }
}
