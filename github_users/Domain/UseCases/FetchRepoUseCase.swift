//
//  FetchRepoUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

protocol FetchRepoUseCase {
    func execute(userName: String) -> AnyPublisher<Repos, AppError>
}
