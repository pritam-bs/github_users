//
//  MockFetchUserDetailsUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Combine
import Foundation
@testable import github_users

class MockFetchUserDetailsUseCase: FetchUserDetailsUseCase {
    var result: Result<UserDetailsEntity, AppError>?
    
    func execute(userLogin: String) -> AnyPublisher<UserDetailsEntity, AppError> {
        return Future<UserDetailsEntity, AppError> { promise in
            if let result = self.result {
                promise(result)
            }
        }.eraseToAnyPublisher()
    }
}
