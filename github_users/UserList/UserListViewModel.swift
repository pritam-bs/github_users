//
//  UserListViewModel.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Combine
import Foundation

class UserListViewModel: ObservableObject {
    @Published var isActive = false
    private var cancellables = Set<AnyCancellable>()
    
    @Published var users: [User] = [
        User(id: 1, name: "John Doe"),
        User(id: 2, name: "Jane Smith")
        // Add more users
    ]
    
    init() {
        Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .first()
            .sink { [weak self] _ in
                self?.isActive = true
            }
            .store(in: &cancellables)
    }
    
}
