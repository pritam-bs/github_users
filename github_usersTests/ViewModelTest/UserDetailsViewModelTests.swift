//
//  UserDetailsViewModelTests.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import XCTest
import Combine
@testable import github_users

class UserDetailsViewModelTests: XCTestCase {
    var viewModel: UserDetailsViewModel!
    var fetchUserDetailsUseCase: MockFetchUserDetailsUseCase!
    var fetchRepositoryUseCase: MockFetchRepositoryUseCase!
    var userDetailsCacheUseCase: MockUserDetailsCacheUseCase!
    var repositoryCacheUseCase: MockRepositoryCacheUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        fetchUserDetailsUseCase = MockFetchUserDetailsUseCase()
        fetchRepositoryUseCase = MockFetchRepositoryUseCase()
        userDetailsCacheUseCase = MockUserDetailsCacheUseCase()
        repositoryCacheUseCase = MockRepositoryCacheUseCase()
        viewModel = UserDetailsViewModel(
            userLogin: "octocat",
            fetchUserDetailsUseCase: fetchUserDetailsUseCase,
            fetchRepositoryUseCase: fetchRepositoryUseCase,
            userDetailsCacheUseCase: userDetailsCacheUseCase,
            repositoryCacheUseCase: repositoryCacheUseCase
        )
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        fetchUserDetailsUseCase = nil
        fetchRepositoryUseCase = nil
        userDetailsCacheUseCase = nil
        repositoryCacheUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchUserDetails_successful() {
        // Given
        let userDetails = UserDetailsEntity(
            avatarURL: "https://avatars.githubusercontent.com/u/1?v=4",
            username: "octocat",
            fullName: "The Octocat",
            followers: 1000,
            followings: 10
        )
        let repositories = [
            RepositoryEntity(id: 1, name: "Repo1", language: "Swift", stars: 100, description: "Repo1 Description", url: "https://github.com/octocat/repo1", fork: false),
            RepositoryEntity(id: 2, name: "Repo2", language: "JavaScript", stars: 200, description: "Repo2 Description", url: "https://github.com/octocat/repo2", fork: false)
        ]
        fetchUserDetailsUseCase.result = .success(userDetails)
        fetchRepositoryUseCase.result = .success(repositories)
        let expectedState = UserDetailsViewModel.LoadingState.loaded

        // When
        viewModel.fetchUserDetails()

        // Then
        viewModel.$state
            .dropFirst() // Skip the initial value
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)

        viewModel.$user
            .dropFirst() // Skip the initial value
            .sink { user in
                XCTAssertEqual(user, userDetails)
            }
            .store(in: &cancellables)

        viewModel.$repositories
            .dropFirst() // Skip the initial value
            .sink { repos in
                XCTAssertEqual(repos, repositories)
            }
            .store(in: &cancellables)
    }

    func test_fetchUserDetails_failure() {
        // Given
        let expectedError = AppError.networkError("Network error")
        fetchUserDetailsUseCase.result = .failure(expectedError)
        fetchRepositoryUseCase.result = .failure(expectedError)
        let expectedState = UserDetailsViewModel.LoadingState.error(expectedError)

        // When
        viewModel.fetchUserDetails()

        // Then
        viewModel.$state
            .dropFirst() // Skip the initial value
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)
    }

    func test_fetchUserDetails_fromCache() {
        // Given
        let userDetails = UserDetailsEntity(
            avatarURL: "https://avatars.githubusercontent.com/u/1?v=4",
            username: "octocat",
            fullName: "The Octocat",
            followers: 1000,
            followings: 10
        )
        let repositories = [
            RepositoryEntity(id: 1, name: "Repo1", language: "Swift", stars: 100, description: "Repo1 Description", url: "https://github.com/octocat/repo1", fork: false),
            RepositoryEntity(id: 2, name: "Repo2", language: "JavaScript", stars: 200, description: "Repo2 Description", url: "https://github.com/octocat/repo2", fork: false)
        ]
        userDetailsCacheUseCase.cachedUserDetails = userDetails
        repositoryCacheUseCase.cachedRepositories = repositories
        let expectedState = UserDetailsViewModel.LoadingState.loaded

        // When
        viewModel.fetchUserDetails()

        // Then
        viewModel.$state
            .dropFirst() // Skip the initial value
            .sink { state in
                XCTAssertEqual(state, expectedState)
            }
            .store(in: &cancellables)

        viewModel.$user
            .sink { user in
                XCTAssertEqual(user, userDetails)
            }
            .store(in: &cancellables)

        viewModel.$repositories
            .sink { repos in
                XCTAssertEqual(repos, repositories)
            }
            .store(in: &cancellables)
    }
}
