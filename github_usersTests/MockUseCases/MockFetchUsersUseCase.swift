//
//  MockFetchUsersUseCase.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class MockFetchUsersUseCase: FetchUsersUseCase {
    var result: Result<UsersEntity, AppError>?
    
    func execute(since id: Int, perPage: Int) -> AnyPublisher<UsersEntity, AppError> {
        let subject = PassthroughSubject<UsersEntity, AppError>()
        if let result = result {
            switch result {
            case .success(let users):
                subject.send(users)
                subject.send(completion: .finished)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
