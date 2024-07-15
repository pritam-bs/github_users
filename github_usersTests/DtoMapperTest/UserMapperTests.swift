//
//  UserMapperTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users

class UserMapperTests: XCTestCase {

    func test_map_userDTO_to_userEntity() {
        let loader = JsonLoader()
        guard let dto = loader.load(filename: "users", as: [UserDTO].self)?.first else {
            XCTFail("Failed to load users.json")
            return
        }
        
        let entity = UserMapper.map(dto: dto)
        
        XCTAssertEqual(entity.login, dto.login)
        XCTAssertEqual(entity.id, dto.id)
        XCTAssertEqual(entity.avatarURL, dto.avatarURL)
    }
}
