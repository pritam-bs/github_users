//
//  NetworkErrorMapper.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

class NetworkErrorMapper {
    static func map(error: NetworkError) -> AppError {
        
        NetworkErrorLogger.shared.log(error)
        
        switch error {
        case .unknown:
            return .unknown
        case .httpError(let statusCode, _):
            return .httpError(statusCode)
        case .decode(let decodingError):
            switch decodingError {
            case .typeMismatch(let type, let context):
                return .decodeError("Type '\(type)' mismatch: \(context.debugDescription) in \(context.codingPath)")
            case .valueNotFound(let type, let context):
                return .decodeError("Value '\(type)' not found: \(context.debugDescription) in \(context.codingPath)")
            case .keyNotFound(let key, let context):
                return .decodeError("Key '\(key)' not found: \(context.debugDescription) in \(context.codingPath)")
            case .dataCorrupted(let context):
                return .decodeError("Data corrupted: \(context.debugDescription) in \(context.codingPath)")
            @unknown default:
                return .decodeError("Unknown decoding error")
            }
        case .network(let urlError):
            switch urlError.code {
            case .notConnectedToInternet:
                return .noInternet
            case .timedOut:
                return .timeout
            default:
                return .networkError(urlError.localizedDescription)
            }
        }
    }
}
