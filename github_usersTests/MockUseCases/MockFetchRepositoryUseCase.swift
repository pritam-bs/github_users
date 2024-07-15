//
//  MockFetchRepositoryUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Combine
import Foundation
@testable import github_users

class MockFetchRepositoryUseCase: FetchRepositoryUseCase {
    var result: Result<[RepositoryEntity], AppError>?
    
    func execute(userLogin: String) -> AnyPublisher<[RepositoryEntity], AppError> {
        return Future<[RepositoryEntity], AppError> { promise in
            if let result = self.result {
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
}
