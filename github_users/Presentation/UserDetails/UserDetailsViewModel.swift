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
    let fetchUserDetailsUseCase: FetchUserDetailsUseCase
    let fetchRepositoryUseCase: FetchRepositoryUseCase
    
    @Published var user: UserDetailsEntity?
    @Published var repositories: [RepositoryEntity] = []
    @Published var state: LoadingState = .initial("Fetching user details, please wait...")
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(userLogin: String,
         fetchUserDetailsUseCase: FetchUserDetailsUseCase,
         fetchRepositoryUseCase: FetchRepositoryUseCase
    ) {
        self.userLogin = userLogin
        self.fetchUserDetailsUseCase = fetchUserDetailsUseCase
        self.fetchRepositoryUseCase = fetchRepositoryUseCase
    }
    
    func fetchUserDetails() {
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
                self.user = userDetails
                // Only original repositories (non-forked)
                self.repositories = repositories.filter{ !$0.fork }
                self.state = .loaded
            })
            .store(in: &cancellables)
    }
}
