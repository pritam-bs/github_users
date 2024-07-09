//
//  CoordinatorView.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//
import SwiftUI

struct CoordinatorView: View {
    @State private var navigationStack: [AppScreen] = []
    
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
            UserListScreen(navigationStack: $navigationStack)
        case .userDetails(let user):
            UserDetailsScreen(viewModel: UserDetailsViewModel(user: user))
        }
    }
}

