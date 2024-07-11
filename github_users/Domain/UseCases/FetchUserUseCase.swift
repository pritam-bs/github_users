//
//  FetchUserUseCase.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Combine
import Foundation

protocol FetchUserUseCase {
    func execute(userName: String) -> AnyPublisher<UserDetails, AppError>
}
