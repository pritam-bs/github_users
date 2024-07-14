//
//  NetworkError.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case httpError(Int, String)
    case decode(DecodingError)
    case network(URLError)
}

