//
//  UsersCacheUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class UsersCacheUseCaseImplTests: XCTestCase {
    var cacheManager: CacheManager<UsersCacheKey, UsersEntity>!
    var useCase: UsersCacheUseCaseImpl<CacheManager<UsersCacheKey, UsersEntity>>!
    
    override func setUp() {
        super.setUp()
        cacheManager = CacheManager<UsersCacheKey, UsersEntity>()
        useCase = UsersCacheUseCaseImpl(cacheManager: cacheManager)
    }
    
    override func tearDown() {
        cacheManager = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_saveToCache() {
        let entity = UsersEntity([UserEntity(login: "testuser", id: 1, avatarURL: "http://example.com/avatar.png")])
        let key = UsersCacheKey(key: "usersKey", since: 0)
        
        useCase.saveToCache(entity: entity, forKey: key)
        
        let cachedEntity = cacheManager.fetch(forKey: key)
        XCTAssertNotNil(cachedEntity)
        XCTAssertEqual(cachedEntity?.first?.id, entity.first?.id)
    }
    
    func test_fetchFromCache() {
        let entity = UsersEntity([UserEntity(login: "testuser", id: 1, avatarURL: "http://example.com/avatar.png")])
        let key = UsersCacheKey(key: "usersKey", since: 0)
        
        cacheManager.save(entity: entity, forKey: key)
        
        let fetchedEntity = useCase.fetchFromCache(forKey: key)
        XCTAssertNotNil(fetchedEntity)
        XCTAssertEqual(fetchedEntity?.first?.id, entity.first?.id)
    }
}
