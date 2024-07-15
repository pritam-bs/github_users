//
//  MockNetworkClient.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Combine
import Foundation
@testable import github_users

class MockNetworkClient: NetworkClient {
    var result: Result<Data, NetworkError>?
    
    func request<T>(router: ApiRouter) -> AnyPublisher<T, NetworkError> where T : Decodable {
        if let result = result {
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedData = try? decoder.decode(T.self, from: data) {
                    return Just(decodedData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.decode(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Decoding error"))))
                        .eraseToAnyPublisher()
                }
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        } else {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }
}

