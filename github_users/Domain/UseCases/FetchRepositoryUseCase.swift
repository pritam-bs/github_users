//
//  FetchRepositoryUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

protocol FetchRepositoryUseCase {
    func execute(userLogin: String) -> AnyPublisher<RepositoriesEntity, AppError>
}
