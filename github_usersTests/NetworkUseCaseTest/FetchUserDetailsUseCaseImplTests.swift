//
//  FetchUserDetailsUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class FetchUserDetailsUseCaseImplTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var fetchUserDetailsUseCase: FetchUserDetailsUseCaseImpl!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        fetchUserDetailsUseCase = FetchUserDetailsUseCaseImpl(networkClient: mockNetworkClient)
        cancellables = []
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        fetchUserDetailsUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchUserDetails_success() {
        let expectation = self.expectation(description: "Fetch user details successfully")
        
        if let userDetailsDTO = JsonLoader().load(filename: "user_octocat", as: UserDetailsDTO.self) {
            let data = try! JSONEncoder().encode(userDetailsDTO)
            mockNetworkClient.result = .success(data)
            
            fetchUserDetailsUseCase.execute(userLogin: "octocat")
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got \(error)")
                    }
                }, receiveValue: { userDetails in
                    XCTAssertEqual(userDetails.avatarURL, userDetailsDTO.avatarURL)
                    XCTAssertEqual(userDetails.username, userDetailsDTO.login)
                    XCTAssertEqual(userDetails.fullName, userDetailsDTO.name)
                    XCTAssertEqual(userDetails.followers, userDetailsDTO.followers)
                    XCTAssertEqual(userDetails.followings, userDetailsDTO.following)
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            waitForExpectations(timeout: 5, handler: nil)
        } else {
            XCTFail("Failed to load user_octocat.json")
        }
    }
    
    func test_fetchUserDetails_failure() {
        let expectation = self.expectation(description: "Fetch user details failed")
        
        mockNetworkClient.result = .failure(NetworkError.httpError(404, "Not Found"))
        
        fetchUserDetailsUseCase.execute(userLogin: "octocat")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, AppError.httpError(404))
                    expectation.fulfill()
                }
            }, receiveValue: { userDetails in
                XCTFail("Expected failure but got \(userDetails)")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
