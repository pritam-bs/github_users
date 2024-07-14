//
//  RepositoryCacheUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

class RepositoryCacheUseCaseImpl<CacheCodableManagerType: CacheCodableManagerProtocol>: RepositoryCacheUseCase
where CacheCodableManagerType.KeyType == RepositoryCacheKey,
      CacheCodableManagerType.DataType == RepositoriesEntity {
    
    private let cacheManager: CacheCodableManagerType
    
    init(cacheManager: CacheCodableManagerType) {
        self.cacheManager = cacheManager
    }
    
    func saveToCache(entity: RepositoriesEntity, forKey key: RepositoryCacheKey) {
        cacheManager.save(entity: entity, forKey: key)
    }
    
    func fetchFromCache(forKey key: RepositoryCacheKey) -> RepositoriesEntity? {
        return cacheManager.fetch(forKey: key)
    }
}
