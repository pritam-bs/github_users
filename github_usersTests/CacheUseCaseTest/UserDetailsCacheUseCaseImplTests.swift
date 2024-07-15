//
//  UserDetailsCacheUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class UserDetailsCacheUseCaseImplTests: XCTestCase {
    var cacheManager: CacheManager<UserDetailsCacheKey, UserDetailsEntity>!
    var useCase: UserDetailsCacheUseCaseImpl<CacheManager<UserDetailsCacheKey, UserDetailsEntity>>!
    
    override func setUp() {
        super.setUp()
        cacheManager = CacheManager<UserDetailsCacheKey, UserDetailsEntity>()
        useCase = UserDetailsCacheUseCaseImpl(cacheManager: cacheManager)
    }
    
    override func tearDown() {
        cacheManager = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_saveToCache() {
        let entity = UserDetailsEntity(avatarURL: "http://example.com/avatar.png", username: "testuser", fullName: "Test User", followers: 100, followings: 50)
        let key = UserDetailsCacheKey(name: "userDetailsKey", login: "testuser")
        
        useCase.saveToCache(entity: entity, forKey: key)
        
        let cachedEntity = cacheManager.fetch(forKey: key)
        XCTAssertNotNil(cachedEntity)
        XCTAssertEqual(cachedEntity?.username, entity.username)
    }
    
    func test_fetchFromCache() {
        let entity = UserDetailsEntity(avatarURL: "http://example.com/avatar.png", username: "testuser", fullName: "Test User", followers: 100, followings: 50)
        let key = UserDetailsCacheKey(name: "userDetailsKey", login: "testuser")
        
        cacheManager.save(entity: entity, forKey: key)
        
        let fetchedEntity = useCase.fetchFromCache(forKey: key)
        XCTAssertNotNil(fetchedEntity)
        XCTAssertEqual(fetchedEntity?.username, entity.username)
    }
}
