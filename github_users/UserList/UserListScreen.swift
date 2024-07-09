//
//  UserListScreen.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import SwiftUI

struct UserListScreen: View {
    @StateObject var viewModel = UserListViewModel()
    @Binding var navigationStack: [AppScreen]
        
    var body: some View {
        List(viewModel.users) { user in
            Button(action: {
                navigationStack.append(.userDetails(user))
            }) {
                Text(user.name)
            }
        }
        .navigationTitle("User List")
    }
}
