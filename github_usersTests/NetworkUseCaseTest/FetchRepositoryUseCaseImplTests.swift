//
//  FetchRepositoryUseCaseImplTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class FetchRepositoryUseCaseImplTests: XCTestCase {
    var mockNetworkClient: MockNetworkClient!
    var fetchRepositoryUseCase: FetchRepositoryUseCaseImpl!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkClient = MockNetworkClient()
        fetchRepositoryUseCase = FetchRepositoryUseCaseImpl(networkClient: mockNetworkClient)
        cancellables = []
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        fetchRepositoryUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_fetchRepositories_success() {
        let expectation = self.expectation(description: "Fetch repositories successfully")
        
        if let repositoriesDTO = JsonLoader().load(filename: "repo", as: RepositoriesDTO.self) {
            let data = try! JSONEncoder().encode(repositoriesDTO)
            mockNetworkClient.result = .success(data)
            
            fetchRepositoryUseCase.execute(userLogin: "octocat")
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got \(error)")
                    }
                }, receiveValue: { repositories in
                    XCTAssertEqual(repositories.count, repositoriesDTO.count)
                    XCTAssertEqual(repositories.first?.id, repositoriesDTO.first?.id)
                    XCTAssertEqual(repositories.first?.name, repositoriesDTO.first?.name)
                    XCTAssertEqual(repositories.first?.language, repositoriesDTO.first?.language  ?? "Unknown")
                    XCTAssertEqual(repositories.first?.stars, repositoriesDTO.first?.stargazersCount)
                    XCTAssertEqual(repositories.first?.description, repositoriesDTO.first?.description ?? "No description")
                    XCTAssertEqual(repositories.first?.url, repositoriesDTO.first?.htmlURL)
                    XCTAssertEqual(repositories.first?.fork, repositoriesDTO.first?.fork)
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            waitForExpectations(timeout: 5, handler: nil)
        } else {
            XCTFail("Failed to load repo.json")
        }
    }
    
    func test_fetchRepositories_failure() {
        let expectation = self.expectation(description: "Fetch repositories failed")
        
        mockNetworkClient.result = .failure(NetworkError.httpError(404, "Not Found"))
        
        fetchRepositoryUseCase.execute(userLogin: "octocat")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, AppError.httpError(404))
                    expectation.fulfill()
                }
            }, receiveValue: { repositories in
                XCTFail("Expected failure but got \(repositories)")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
