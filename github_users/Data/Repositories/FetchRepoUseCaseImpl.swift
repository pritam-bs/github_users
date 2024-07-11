//
//  FetchRepoUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

class FetchRepoUseCaseImpl: FetchRepoUseCase {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func execute(userName: String) -> AnyPublisher<Repos, AppError> {
        return networkClient.request(router: ApiRouter.repo(userName))
            .mapError({ netWorkError in
                NetworkErrorMapper.map(error: netWorkError)
            })
            .eraseToAnyPublisher()
    }
}
