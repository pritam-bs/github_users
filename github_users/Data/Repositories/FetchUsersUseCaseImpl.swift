//
//  FetchUsersUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

class FetchUsersUseCaseImpl: FetchUsersUseCase {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func execute(since id: Int, perPage: Int) -> AnyPublisher<Users, AppError> {
        return networkClient.request(router: ApiRouter.users(id, perPage))
            .map { (users: UsersDTO) in
                UserMapper.map(dto: users)
            }
            .mapError({ netWorkError in
                NetworkErrorMapper.map(error: netWorkError)
            })
            .eraseToAnyPublisher()
    }
}
