//
//  UserDetailsMapperTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class UserDetailsMapperTests: XCTestCase {
    
    func test_map_userDetailsDTO_to_userDetailsEntity() {
        let loader = JsonLoader()
        guard let dto = loader.load(filename: "user_octocat", as: UserDetailsDTO.self) else {
            XCTFail("Failed to load user_octocat.json")
            return
        }
        
        let entity = UserDetailsMapper.map(dto: dto)
        
        XCTAssertEqual(entity.avatarURL, dto.avatarURL)
        XCTAssertEqual(entity.username, dto.login)
        XCTAssertEqual(entity.fullName, dto.name)
        XCTAssertEqual(entity.followers, dto.followers)
        XCTAssertEqual(entity.followings, dto.following)
    }
}

