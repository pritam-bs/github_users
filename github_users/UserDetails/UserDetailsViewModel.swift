//
//  UserDetailsViewModel.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation

class UserDetailsViewModel: ObservableObject {
    let user: User
    
    init(user: User) {
        self.user = user
    }
}
