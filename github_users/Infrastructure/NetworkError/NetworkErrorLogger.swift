//
//  NetworkErrorLogger.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

class NetworkErrorLogger {
    static let shared = NetworkErrorLogger()
    
    private init() {}
    
    func log(_ error: NetworkError) {
        switch error {
        case .unknown:
            Logger.shared.log("Unknown network error occurred.", level: .error)
        case .httpError(let statusCode, let statusDescription):
            Logger.shared.log("HTTP Error \(statusCode): \(statusDescription)", level: .error)
        case .decode(let decodingError):
            logDecodingError(decodingError)
        case .network(let urlError):
            logNetworkError(urlError)
        }
    }
    
    private func logDecodingError(_ decodingError: DecodingError) {
        switch decodingError {
        case .typeMismatch(let type, let context):
            Logger.shared.log("Type '\(type)' mismatch: \(context.debugDescription) in \(context.codingPath)", level: .error)
        case .valueNotFound(let type, let context):
            Logger.shared.log("Value '\(type)' not found: \(context.debugDescription) in \(context.codingPath)", level: .error)
        case .keyNotFound(let key, let context):
            Logger.shared.log("Key '\(key)' not found: \(context.debugDescription) in \(context.codingPath)", level: .error)
        case .dataCorrupted(let context):
            Logger.shared.log("Data corrupted: \(context.debugDescription) in \(context.codingPath)", level: .error)
        @unknown default:
            Logger.shared.log("Unknown decoding error", level: .error)
        }
    }
    
    private func logNetworkError(_ urlError: URLError) {
        switch urlError.code {
        case .notConnectedToInternet:
            Logger.shared.log("No internet connection is available.", level: .error)
        case .timedOut:
            Logger.shared.log("The request timed out.", level: .error)
        default:
            Logger.shared.log("Network error: \(urlError.localizedDescription)", level: .error)
        }
    }
}
