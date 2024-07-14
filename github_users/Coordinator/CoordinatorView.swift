//
//  CoordinatorView.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//
import SwiftUI

struct CoordinatorView: View {
    @State private var navigationStack: [AppScreen] = []
    
    private let usersCacheManager = CacheManager<UsersCacheKey, UsersEntity>()
    private let userDetailsCacheManager = CacheManager<UserDetailsCacheKey, UserDetailsEntity>()
    private let repositoryCacheManager = CacheManager<RepositoryCacheKey, RepositoriesEntity>()
    
    var body: some View {
        NavigationStack(path: $navigationStack) {
            destinationView(for: .userList)
                .navigationDestination(for: AppScreen.self) { state in
                    destinationView(for: state)
                }
        }
    }
    
    @ViewBuilder
    private func destinationView(for state: AppScreen) -> some View {
        switch state {
        case .userList:
            let networkClient = DefaultNetworkClient(config: URLSessionConfiguration.default)
            let fetchUsersUseCase = FetchUsersUseCaseImpl(networkClient: networkClient)
            
            let usersCacheUseCase = UsersCacheUseCaseImpl(cacheManager: usersCacheManager)
            
            let viewModel = UserListViewModel(
                fetchUsersUseCase: fetchUsersUseCase,
                usersCacheUseCase: usersCacheUseCase
            )
            
            UserListScreen(viewModel: viewModel, navigationStack: $navigationStack)
        case .userDetails(let user):
            let networkClient = DefaultNetworkClient(config: URLSessionConfiguration.default)
            let fetchUserDetailsUseCase = FetchUserDetailsUseCaseImpl(networkClient: networkClient)
            let fetchRepositoryUseCase = FetchRepositoryUseCaseImpl(networkClient: networkClient)
            
            let userDetailsCacheUseCase = UserDetailsCacheUseCaseImpl(cacheManager: userDetailsCacheManager)
            let repositoryCacheUseCase = RepositoryCacheUseCaseImpl(cacheManager: repositoryCacheManager)
            
            let viewModel = UserDetailsViewModel(
                userLogin: user.login,
                fetchUserDetailsUseCase: fetchUserDetailsUseCase,
                fetchRepositoryUseCase: fetchRepositoryUseCase,
                userDetailsCacheUseCase: userDetailsCacheUseCase,
                repositoryCacheUseCase: repositoryCacheUseCase
            )
            
            UserDetailsScreen(viewModel: viewModel, navigationStack: $navigationStack)
        }
    }
}

