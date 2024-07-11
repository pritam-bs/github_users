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
    
    @Published var users: Users = []
    @Published var state: LoadingState = .initial("Fetching users, please wait...")
    
    private var fetchUsersUseCase: FetchUsersUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }
    
    func fetchUsers(perPage: Int = 30) {
        let id = users.last?.id ?? 0
        if id > 0 {
            state = .loadingNext
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
                    self.users.append(contentsOf: users)
                    self.state = .loaded
                })
                .store(in: &cancellables)
        }
}
