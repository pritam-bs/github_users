//
//  Network.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import Combine

class DefaultNetworkClient: NetworkClient {
    let config: URLSessionConfiguration
    private let decoder: JSONDecoder
    
    init(config: URLSessionConfiguration) {
        self.config = config
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func request<T: Decodable>(router: ApiRouter) -> AnyPublisher<T, NetworkError> {
        
        guard let urlRequest = router.asURLRequest() else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: config)
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    let statusCode = (result.response as? HTTPURLResponse)?.statusCode ?? -1
                    let description = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                    throw NetworkError.httpError(statusCode, description)
                }
                return result.data
                
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> NetworkError in
                if let urlError = error as? URLError {
                    return .network(urlError)
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else if let decodingError = error as? DecodingError {
                    return .decode(decodingError)
                } else {
                    return .unknown
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


