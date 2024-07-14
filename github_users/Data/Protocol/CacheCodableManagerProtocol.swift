//
//  CacheManagerProtocol.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

protocol CacheCodableManagerProtocol {
    associatedtype KeyType: Hashable & Equatable
    associatedtype DataType: Codable
    
    func save(entity: DataType, forKey key: KeyType)
    func fetch(forKey key: KeyType) -> DataType?
    func clearCache()
}
