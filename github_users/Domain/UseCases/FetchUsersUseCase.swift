//
//  UseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Combine

protocol FetchUsersUseCase {
    func execute(since id: Int, perPage: Int) -> AnyPublisher<UsersEntity, AppError>
}
