//
//  AppError.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Foundation

enum AppError: Error, Equatable {
    case unknown
    case httpError(Int)
    case decodeError(String)
    case networkError(String)
    case noInternet
    case timeout
    case cache
    
    var localizedDescription: String {
      switch self {
      case .unknown:
          return "An unexpected error occurred. Please try again."
      case .httpError(let statusCode):
          switch statusCode {
          case 400..<500:
              return "There was a problem with your request. Please check and try again."
          case 500..<600:
              return "The server encountered an error. Please try again later."
          default:
              return "An HTTP error occurred. Please try again."
          }
      case .decodeError:
          return "There was an error processing your request. Please try again."
      case .networkError:
          return "A network error occurred. Please check your connection and try again."
      case .noInternet:
          return "No internet connection is available. Please check your connection and try again."
      case .timeout:
          return "The request timed out. Please check your connection and try again."
      case .cache:
          return "Caching failed"
      }
    }
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
            (.noInternet, .noInternet),
            (.timeout, .timeout):
            return true
        case (.httpError(let lhsMessage), .httpError(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.decodeError(let lhsMessage), .decodeError(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.networkError(let lhsMessage), .networkError(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
