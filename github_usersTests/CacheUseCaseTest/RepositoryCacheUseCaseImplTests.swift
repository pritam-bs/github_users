//
//  RepositoryCacheUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users


class RepositoryCacheUseCaseImplTests: XCTestCase {
    var cacheManager: CacheManager<RepositoryCacheKey, RepositoriesEntity>!
    var useCase: RepositoryCacheUseCaseImpl<CacheManager<RepositoryCacheKey, RepositoriesEntity>>!
    
    override func setUp() {
        super.setUp()
        cacheManager = CacheManager<RepositoryCacheKey, RepositoriesEntity>()
        useCase = RepositoryCacheUseCaseImpl(cacheManager: cacheManager)
    }
    
    override func tearDown() {
        cacheManager = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_saveToCache() {
        let entity = RepositoriesEntity([RepositoryEntity(id: 1, name: "Test Repo", language: "Swift", stars: 100, description: "A test repository", url: "http://example.com/repo", fork: false)])
        let key = RepositoryCacheKey(name: "repoKey", login: "testuser")
        
        useCase.saveToCache(entity: entity, forKey: key)
        
        let cachedEntity = cacheManager.fetch(forKey: key)
        XCTAssertNotNil(cachedEntity)
        XCTAssertEqual(cachedEntity?.first?.id, entity.first?.id)
    }
    
    func test_fetchFromCache() {
        let entity = RepositoriesEntity([RepositoryEntity(id: 1, name: "Test Repo", language: "Swift", stars: 100, description: "A test repository", url: "http://example.com/repo", fork: false)])
        let key = RepositoryCacheKey(name: "repoKey", login: "testuser")
        
        cacheManager.save(entity: entity, forKey: key)
        
        let fetchedEntity = useCase.fetchFromCache(forKey: key)
        XCTAssertNotNil(fetchedEntity)
        XCTAssertEqual(fetchedEntity?.first?.id, entity.first?.id)
    }
}
