//
//  RepositoryCacheUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 14.07.2024.
//

import Foundation

protocol RepositoryCacheUseCase {
    func saveToCache(entity: RepositoriesEntity, forKey key: RepositoryCacheKey)
    func fetchFromCache(forKey key: RepositoryCacheKey) -> RepositoriesEntity?
}
