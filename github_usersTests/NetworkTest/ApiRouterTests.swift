//
//  ApiRouterTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
@testable import github_users


class ApiRouterTests: XCTestCase {
    var apiRouter: ApiRouter?
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        apiRouter = nil
        super.tearDown()
    }

    func test_users_api_route() {
        apiRouter = ApiRouter.users(0, 30)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/users"
        urlComponents.queryItems = [
            URLQueryItem(name: "since", value: "0"),
            URLQueryItem(name: "per_page", value: "30")
        ]
        
        var urlRequest = URLRequest(url: urlComponents.url!,
                                    cachePolicy: NetworkProperties.cachePolicy,
                                    timeoutInterval: NetworkProperties.timeOut)
        urlRequest.httpMethod = "get"
        urlRequest.timeoutInterval = NetworkProperties.timeOut
        XCTAssertEqual(urlRequest.url, apiRouter?.asURLRequest()?.url)
        XCTAssertEqual(urlRequest.httpMethod, apiRouter?.asURLRequest()?.httpMethod)
    }
    
    func test_user_details_api_route() {
        apiRouter = ApiRouter.userDetails("octocat")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/users/octocat"
        
        var urlRequest = URLRequest(url: urlComponents.url!,
                                    cachePolicy: NetworkProperties.cachePolicy,
                                    timeoutInterval: NetworkProperties.timeOut)
        urlRequest.httpMethod = "get"
        urlRequest.timeoutInterval = NetworkProperties.timeOut
        XCTAssertEqual(urlRequest.url, apiRouter?.asURLRequest()?.url)
        XCTAssertEqual(urlRequest.httpMethod, apiRouter?.asURLRequest()?.httpMethod)
    }
    
    func test_repo_api_route() {
        apiRouter = ApiRouter.repo("octocat")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/users/octocat/repos"
        
        var urlRequest = URLRequest(url: urlComponents.url!,
                                    cachePolicy: NetworkProperties.cachePolicy,
                                    timeoutInterval: NetworkProperties.timeOut)
        urlRequest.httpMethod = "get"
        urlRequest.timeoutInterval = NetworkProperties.timeOut
        XCTAssertEqual(urlRequest.url, apiRouter?.asURLRequest()?.url)
        XCTAssertEqual(urlRequest.httpMethod, apiRouter?.asURLRequest()?.httpMethod)
    }
}
