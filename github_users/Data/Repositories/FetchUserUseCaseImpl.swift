//
//  FetchUserUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

class FetchUserUseCaseImpl: FetchUserUseCase {
    
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func execute(userName: String) -> AnyPublisher<UserDetails, AppError> {
        return networkClient.request(router: ApiRouter.userDetails(userName))
            .mapError({ netWorkError in
                NetworkErrorMapper.map(error: netWorkError)
            })
            .eraseToAnyPublisher()
    }
}
