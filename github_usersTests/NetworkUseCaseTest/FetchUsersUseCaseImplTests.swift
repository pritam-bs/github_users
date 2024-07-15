//
//  FetchUsersUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class FetchUsersUseCaseImplTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var fetchUsersUseCase: FetchUsersUseCaseImpl!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        fetchUsersUseCase = FetchUsersUseCaseImpl(networkClient: mockNetworkClient)
        cancellables = []
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        fetchUsersUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchUsers_success() {
        let expectation = self.expectation(description: "Fetch users successfully")
        
        if let usersDTO = JsonLoader().load(filename: "users", as: UsersDTO.self) {
            let data = try! JSONEncoder().encode(usersDTO)
            mockNetworkClient.result = .success(data)
            
            fetchUsersUseCase.execute(since: 0, perPage: 10)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got \(error)")
                    }
                }, receiveValue: { users in
                    XCTAssertEqual(users.count, usersDTO.count)
                    XCTAssertEqual(users.first?.id, usersDTO.first?.id)
                    XCTAssertEqual(users.first?.login, usersDTO.first?.login)
                    XCTAssertEqual(users.first?.avatarURL, usersDTO.first?.avatarURL)
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            waitForExpectations(timeout: 5, handler: nil)
        } else {
            XCTFail("Failed to load users.json")
        }
    }
    
    func test_fetchUsers_failure() {
        let expectation = self.expectation(description: "Fetch users failed")
        
        mockNetworkClient.result = .failure(NetworkError.httpError(404, "Not Found"))
        
        fetchUsersUseCase.execute(since: 0, perPage: 10)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, AppError.httpError(404))
                    expectation.fulfill()
                }
            }, receiveValue: { users in
                XCTFail("Expected failure but got \(users)")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
