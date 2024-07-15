//
//  DefaultNetworkClientTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class DefaultNetworkClientTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var networkClient: DefaultNetworkClient!

    override func setUp() {
        super.setUp()
        cancellables = []
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        networkClient = DefaultNetworkClient(config: config)
    }

    override func tearDown() {
        cancellables = nil
        networkClient = nil
        super.tearDown()
    }

    func test_successful_network_request_and_decode() {
        let expectation = self.expectation(description: "Successful network request and decode")
        
        let usersApi = ApiRouter.users(0, 30)
        
        let path = Bundle(for: type(of: self)).path(forResource: "users", ofType: "json")
        
        let mockData = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        
        let mockResponse = HTTPURLResponse(url: (usersApi.asURLRequest()?.url!)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!

        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        networkClient.request(router: usersApi)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error \(error)")
                }
            }, receiveValue: { (users: UsersDTO) in
                XCTAssertEqual(users.count, 30)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_http_network_error_handling() {
        let expectation = self.expectation(description: "Successful handle httpError network error")
        
        let usersApi = ApiRouter.users(0, 30)
        
        let mockData: Data? = nil
        
        let mockResponse = HTTPURLResponse(url: (usersApi.asURLRequest()?.url!)!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)!

        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        networkClient.request(router: usersApi)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case NetworkError.httpError(let statusCode, _) = error {
                        XCTAssertEqual(statusCode, 404)
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected NetworkError.httpError but got \(error)")
                    }
                }
            }, receiveValue: { (users: UsersDTO) in
                XCTAssertNil(users)
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_decode_error_handling() {
        let expectation = self.expectation(description: "Successful handle decode error")
        
        let usersApi = ApiRouter.repo("octocat")
        
        let path = Bundle(for: type(of: self)).path(forResource: "repo_invalid", ofType: "json")
        
        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        
        let mockResponse = HTTPURLResponse(url: (usersApi.asURLRequest()?.url!)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            return (mockResponse, mockData)
        }
        
        networkClient.request(router: usersApi)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case NetworkError.decode(_) = error {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected NetworkError.decode but got \(error)")
                    }
                }
            }, receiveValue: { (users: UsersDTO) in
                XCTAssertNil(users)
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_timeout_error_handling() {
        let expectation = self.expectation(description: "Successful handle timeout error")
        
        let usersApi = ApiRouter.users(0, 30)
        
        MockURLProtocol.requestHandler = { request in
            throw URLError(.timedOut)
        }
        
        networkClient.request(router: usersApi)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case NetworkError.network(let urlError) = error, urlError.code == .timedOut {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected NetworkError.network with timeout code but got \(error)")
                    }
                }
            }, receiveValue: { (users: UsersDTO) in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_url_error_handling() {
        let expectation = self.expectation(description: "Successful handle URL error")
        
        let usersApi = ApiRouter.users(0, 30)
        
        MockURLProtocol.requestHandler = { request in
            throw URLError(.unsupportedURL)
        }
        
        networkClient.request(router: usersApi)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case NetworkError.network(let urlError) = error, urlError.code == .unsupportedURL {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected NetworkError.network with unsupportedURL code but got \(error)")
                    }
                }
            }, receiveValue: { (users: UsersDTO) in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
