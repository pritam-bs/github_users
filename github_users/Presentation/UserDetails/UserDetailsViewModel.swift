//
//  UserDetailsViewModel.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Combine
import Foundation

class UserDetailsViewModel: ObservableObject {
    enum LoadingState {
        case initial(String)
        case loaded
        case error(AppError)
    }
    
    let userLogin: String
    private let fetchUserDetailsUseCase: FetchUserDetailsUseCase
    private let fetchRepositoryUseCase: FetchRepositoryUseCase
    private let userDetailsCacheUseCase: UserDetailsCacheUseCase
    private let repositoryCacheUseCase: RepositoryCacheUseCase
    
    private let userDetailsCacheKeyName = "UserDetailsCacheKay"
    private let repositoryCacheKeyName = "repositoryCacheKey"
    private let userDetailsCacheKey: UserDetailsCacheKey
    private let repositoryCacheKey: RepositoryCacheKey
    
    @Published var user: UserDetailsEntity?
    @Published var repositories: [RepositoryEntity] = []
    @Published var state: LoadingState = .initial("Fetching user details, please wait...")
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(userLogin: String,
         fetchUserDetailsUseCase: FetchUserDetailsUseCase,
         fetchRepositoryUseCase: FetchRepositoryUseCase,
         userDetailsCacheUseCase: UserDetailsCacheUseCase,
         repositoryCacheUseCase: RepositoryCacheUseCase
    ) {
        self.userLogin = userLogin
        self.fetchUserDetailsUseCase = fetchUserDetailsUseCase
        self.fetchRepositoryUseCase = fetchRepositoryUseCase
        self.userDetailsCacheUseCase = userDetailsCacheUseCase
        self.repositoryCacheUseCase = repositoryCacheUseCase
        self.userDetailsCacheKey = UserDetailsCacheKey(name: userDetailsCacheKeyName, login: userLogin)
        self.repositoryCacheKey = RepositoryCacheKey(name: repositoryCacheKeyName, login: userLogin)
    }
    
    func fetchUserDetails() {
        // Fetch from cache
        let userDetails = userDetailsCacheUseCase.fetchFromCache(forKey: userDetailsCacheKey)
        let repositories = repositoryCacheUseCase.fetchFromCache(forKey: repositoryCacheKey)
        
        if let userDetails = userDetails, let repositories = repositories {
            // Update UI
            user = userDetails
            self.repositories = repositories
            self.state = .loaded
            
            return
        }
        
        let userDetailsPublisher = fetchUserDetailsUseCase.execute(userLogin: userLogin)
        let repositorysPublisher = fetchRepositoryUseCase.execute(userLogin: userLogin)
        
        let combinedPublisher = userDetailsPublisher
            .zip(repositorysPublisher)
            .eraseToAnyPublisher()
        
        combinedPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .error(error)
                }
            }, receiveValue: { [weak self] (userDetails, repositories) in
                guard let self = self else { return }
                // Only original repositories (non-forked)
                let repositoriesNonFork = repositories.filter{ !$0.fork }
                
                // Save to cache
                self.userDetailsCacheUseCase.saveToCache(entity: userDetails, forKey: self.userDetailsCacheKey)
                self.repositoryCacheUseCase.saveToCache(entity: repositoriesNonFork, forKey: self.repositoryCacheKey)
                
                // Update UI
                self.user = userDetails
                self.repositories = repositoriesNonFork
                self.state = .loaded
            })
            .store(in: &cancellables)
    }
}
