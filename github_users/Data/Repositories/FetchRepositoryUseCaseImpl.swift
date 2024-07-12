//
//  FetchRepositoryUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

class FetchRepositoryUseCaseImpl: FetchRepositoryUseCase {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func execute(userLogin: String) -> AnyPublisher<RepositorysEntity, AppError> {
        return networkClient.request(router: ApiRouter.repo(userLogin))
            .map { (repositorysDTO: RepositoriesDTO) in
                RepositoryMapper.map(dto: repositorysDTO)
            }
            .mapError { netWorkError in
                NetworkErrorMapper.map(error: netWorkError)
            }
            .eraseToAnyPublisher()
    }
}
