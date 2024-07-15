//
//  UserListViewModelTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class UserListViewModelTests: XCTestCase {
    var viewModel: UserListViewModel!
    var fetchUsersUseCase: MockFetchUsersUseCase!
    var usersCacheUseCase: MockUsersCacheUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        fetchUsersUseCase = MockFetchUsersUseCase()
        usersCacheUseCase = MockUsersCacheUseCase()
        viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase, usersCacheUseCase: usersCacheUseCase)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        fetchUsersUseCase = nil
        usersCacheUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchUsers_initialLoadingState() {
        // Given
        let expectedState = UserListViewModel.LoadingState.initial("Fetching users, please wait...")

        // When
        viewModel.$state
            .sink { state in
                // Then
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)
    }

    func test_fetchUsers_successful() {
        // Given
        let users: UsersEntity = [
            UserEntity(login: "mojombo", id: 1, avatarURL: "https://avatars.githubusercontent.com/u/1?v=4"),
            UserEntity(login: "defunkt", id: 2, avatarURL: "https://avatars.githubusercontent.com/u/2?v=4")
        ]
        fetchUsersUseCase.result = .success(users)
        let expectedState = UserListViewModel.LoadingState.loaded

        // When
        viewModel.fetchUsers(since: 0)

        // Then
        viewModel.$state
            .dropFirst()
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)

        viewModel.$users
            .dropFirst()
            .sink { fetchedUsers in
                let usersSet = UserOrderedSet(array: users)
                XCTAssertEqual(fetchedUsers, usersSet)
            }
            .store(in: &cancellables)
    }

    func test_fetchUsers_failure() {
        // Given
        let expectedError = AppError.networkError("Network error")
        fetchUsersUseCase.result = .failure(expectedError)
        let expectedState = UserListViewModel.LoadingState.initialWithError(expectedError)

        // When
        viewModel.fetchUsers(since: 0)

        // Then
        viewModel.$state
            .dropFirst()
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)
    }

    func test_fetchUsers_fromCache() {
        // Given
        let users: UsersEntity = [
            UserEntity(login: "mojombo", id: 1, avatarURL: "https://avatars.githubusercontent.com/u/1?v=4"),
            UserEntity(login: "defunkt", id: 2, avatarURL: "https://avatars.githubusercontent.com/u/2?v=4")
        ]
        let key = UsersCacheKey(key: "UsersCacheKey", since: 0)
        usersCacheUseCase.saveToCache(entity: users, forKey: key)
        let expectedState = UserListViewModel.LoadingState.loaded

        // When
        viewModel.fetchUsers(since: 0)

        // Then
        viewModel.$state
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)

        viewModel.$users
            .sink { fetchedUsers in
                let usersSet = UserOrderedSet(array: users)
                XCTAssertEqual(fetchedUsers, usersSet)
            }.store(in: &cancellables)
    }
}
