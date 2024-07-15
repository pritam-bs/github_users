//
//  FetchUserUseCaseImpl.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

class FetchUserDetailsUseCaseImpl: FetchUserDetailsUseCase {
    
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func execute(userLogin: String) -> AnyPublisher<UserDetailsEntity, AppError> {
        return networkClient.request(router: ApiRouter.userDetails(userLogin))
            .map{ (userDetailsDTO: UserDetailsDTO) in
                UserDetailsMapper.map(dto: userDetailsDTO)
            }
            .mapError { netWorkError in
                NetworkErrorMapper.map(error: netWorkError)
            }
            .eraseToAnyPublisher()
    }
}
