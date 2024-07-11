//
//  NetworkConstants.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation

public enum MethodType: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

public enum ContentType: String {
    case json = "application/json; charset=utf-8"
    case urlencoded = "application/x-www-form-urlencoded"
    case password = "X- -Password"
}

public enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case ifModifiedSince = "If-Modified-Since"
}

struct NetworkProperties {
    static var timeOut: TimeInterval { return 60 }
    static var cachePolicy: URLRequest.CachePolicy { return .useProtocolCachePolicy }
}

