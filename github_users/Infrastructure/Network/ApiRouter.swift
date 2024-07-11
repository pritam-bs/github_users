//
//  ApiRouter.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation

enum ApiRouter {
    case users(Int, Int)
    case userDetails(String)
    case repo(String)
    
    var domain: String {
        switch self {
        default:
            return ApiConfig.domain
        }
    }
    
    var apiVersion: String {
        switch self {
        default:
            return ApiConfig.apiVersion
        }
    }
    
    var method: MethodType {
        switch self {
        case .users:
            return .get
        case .userDetails:
            return .get
        case .repo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case .userDetails(let userName):
            return "/\(userName)"
        case .repo(let userName):
            return "/\(userName)/repos"
        }
    }
    
    var urlComponents: URLComponents? {
        let scheme = "https://"
        return URLComponents(string: scheme + domain + apiVersion + path)
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .users(let id, let perPage):
            return [
                URLQueryItem(name: "since", value: String(id)),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        case .userDetails:
            return nil
        case .repo:
            return nil
        }
    }
        
    var body: Data? {
        switch self {
        case .users:
            return nil
        case .userDetails:
            return nil
        case .repo:
            return nil
        }
    }
    
    var formUrlencoded: Data? {
        switch self {
        case .users:
            return nil
        case .userDetails:
            return nil
        case .repo:
            return nil
        }
    }
    
    var cookie: HTTPCookie? {
        return nil
    }
    
    var headers: [String: String]? {
        if let cookie = cookie {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
        
        var headers = [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
        ]
        
        if let url = urlComponents?.url {
            let cookies = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies(for: url) ?? [])
            for cookie in cookies {
                headers[cookie.key] = cookie.value
            }
        }
        
        return headers
    }
    
    func asURLRequest() -> URLRequest? {
        guard var urlComponents = urlComponents else {
            return nil
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: NetworkProperties.cachePolicy,
                                    timeoutInterval: NetworkProperties.timeOut)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = NetworkProperties.timeOut
        
        return urlRequest
    }
}



