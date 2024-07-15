//
//  RepositoryMapperTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class RepositoryMapperTests: XCTestCase {

    func test_map_repositoryDTO_to_repositoryEntity() {
        let loader = JsonLoader()
        guard let dto = loader.load(filename: "repo", as: [RepositoryDTO].self)?.first else {
            XCTFail("Failed to load repo.json")
            return
        }
        
        let entity = RepositoryMapper.map(dto: dto)
        
        XCTAssertEqual(entity.id, dto.id)
        XCTAssertEqual(entity.name, dto.name)
        XCTAssertEqual(entity.language, dto.language ?? "Unknown")
        XCTAssertEqual(entity.stars, dto.stargazersCount)
        XCTAssertEqual(entity.description, dto.description ?? "No description")
        XCTAssertEqual(entity.url, dto.htmlURL)
        XCTAssertEqual(entity.fork, dto.fork)
    }
}
