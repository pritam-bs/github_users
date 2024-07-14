//
//  UserListViewModel.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Combine
import Foundation

class UserListViewModel: ObservableObject {
    enum LoadingState {
        case initial(String)
        case initialWithError(AppError)
        case loaded
        case loadingNext
        case error(AppError)
    }
    
    @Published var users: UserOrderedSet<UserEntity> = []
    @Published var state: LoadingState = .initial("Fetching users, please wait...")
    
    private var fetchUsersUseCase: FetchUsersUseCase
    private var usersCacheUseCase: UsersCacheUseCase
    private let usersCacheKey = "UsersCacheKey"
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchUsersUseCase: FetchUsersUseCase,
         usersCacheUseCase: UsersCacheUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
        self.usersCacheUseCase = usersCacheUseCase
    }
    
    func fetchUsers(since id: Int, perPage: Int = 30) {
        if !users.isEmpty {
            state = .loadingNext
        }
        
        let key = UsersCacheKey(key: usersCacheKey, since: id)
        if let cachedUsers =  self.usersCacheUseCase.fetchFromCache(forKey: key) {
            self.users.append(contentsOf: cachedUsers)
            self.state = .loaded
            
            return
        }
        
        fetchUsersUseCase.execute(since: id, perPage: perPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    state = .loaded
                    break
                case .failure(let error):
                    guard !self.users.isEmpty else {
                        self.state = .initialWithError(error)
                        return
                    }
                    self.state = .error(error)
                }
            }, receiveValue: { [weak self] users in
                guard let self = self else { return }
                
                // Save fetched users to cache
                if let since = self.users.isEmpty ? 0 : users.last?.id {
                    let key = UsersCacheKey(key: usersCacheKey, since: since)
                    self.usersCacheUseCase.saveToCache(entity: users, forKey: key)
                }
                
                self.users.append(contentsOf: users)
                self.state = .loaded
            })
            .store(in: &cancellables)
    }
}
