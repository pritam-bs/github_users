//
//  CacheManagerTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class CacheManagerTests: XCTestCase {
    var cacheManager: CacheManager<String, User>!

    override func setUp() {
        super.setUp()
        cacheManager = CacheManager<String, User>()
    }

    override func tearDown() {
        cacheManager = nil
        super.tearDown()
    }

    func test_save_and_fetch_entity() {
        let user = User(id: 1, name: "Pritam", email: "pritam@example.com")
        let key = "userKey"
        
        cacheManager.save(entity: user, forKey: key)
        
        let fetchedUser = cacheManager.fetch(forKey: key)
        
        XCTAssertNotNil(fetchedUser)
        XCTAssertEqual(fetchedUser?.id, user.id)
        XCTAssertEqual(fetchedUser?.name, user.name)
        XCTAssertEqual(fetchedUser?.email, user.email)
    }
    
    func test_fetch_non_existing_entity() {
        let key = "non_existing_user"
        
        let fetchedUser = cacheManager.fetch(forKey: key)
        
        XCTAssertNil(fetchedUser)
    }

    func test_clear_cache() {
        let user = User(id: 1, name: "Pritam", email: "pritam@example.com")
        let key = "userKey"
        
        cacheManager.save(entity: user, forKey: key)
        cacheManager.clearCache()
        
        let fetchedUser = cacheManager.fetch(forKey: key)
        
        XCTAssertNil(fetchedUser)
    }
}

// Mock User model for testing
struct User: Codable, Equatable {
    let id: Int
    let name: String
    let email: String
}
