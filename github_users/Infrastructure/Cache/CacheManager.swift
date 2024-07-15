//
//  CacheManager.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

class CacheManager<Key: Hashable & Equatable, DataType: Codable>: CacheCodableManagerProtocol {
    private var cache: NSCache = NSCache<WrappedKey, NSData>()
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init() {
        cache = NSCache<WrappedKey, NSData>()
        
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
    }
    
    func save(entity: DataType, forKey key: Key) {
        let wrappedKey = WrappedKey(key)
        
        do {
            let data = try encoder.encode(entity)
            let nsData = NSData(data: data)
            cache.setObject(nsData, forKey: wrappedKey)
        } catch {
            Logger.shared.log("Failed to cache \(DataType.self)", level: .debug)
        }
    }
    
    func fetch(forKey key: Key) -> DataType? {
        let wrappedKey = WrappedKey(key)
        
        guard let nsData = cache.object(forKey: wrappedKey) else {
            Logger.shared.log("No data found in the cache for type: \(DataType.self)", level: .debug)
            return nil
        }
        
        let data = Data(referencing: nsData)
        
        do {
            let object = try JSONDecoder().decode(DataType.self, from: data)
            return object
        } catch {
            Logger.shared.log("Failed fetch from cache \(DataType.self)", level: .debug)
            return nil
        }
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    private class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? WrappedKey else { return false }
            return key == other.key
        }
    }
}
