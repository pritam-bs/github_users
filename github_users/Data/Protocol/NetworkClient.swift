//
//  NetworkClientProtocol.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

protocol NetworkClient {
    func request<T: Decodable>(router: ApiRouter) -> AnyPublisher<T, NetworkError>
}
