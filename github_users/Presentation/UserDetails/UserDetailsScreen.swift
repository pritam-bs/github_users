//
//  UserDetailsScreen.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import SwiftUI

struct UserDetailsScreen: View {
    @StateObject var viewModel: UserDetailsViewModel
    @Binding var navigationStack: [AppScreen]
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .initial(let message):
                makeEmptyView(message: message)
            case .error(let error):
                makeErrorView(error: error)
            default:
                contentView
            }
        }
        .navigationTitle("User Details")
        .onAppear{
            viewModel.fetchUserDetails()
        }
    }
    
    // Initial message when the list is empty
    private func makeEmptyView(message: String) -> some View {
        Text(message)
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding()
    }
    
    // Error view and retry button for only no internet and timeout
    private func makeErrorView(error: AppError) -> some View {
        Group {
            switch error {
            case .noInternet, .timeout:
                VStack {
                    Text(error.localizedDescription)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    // Retry button
                    Button{
                        viewModel.fetchUserDetails()
                    } label: {
                        Text("Try again")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(4)
                            .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
                    }
                }
                .padding()
            default:
                Text(error.localizedDescription)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
    
    // Combine view with user info and repo list
    var contentView: some View {
        List {
            if let user = viewModel.user {
                // User info view
                HStack {
                    Spacer()
                    UserView(userDetails: user)
                        .padding(.bottom, 16)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                
            }
            
            // Repo list view
            ForEach(viewModel.repositories) { repository in
                NavigationLink(value: AppScreen.repositoryWebView(repository.url, repository.name)) {
                    RepositoryListItemView(repository: repository)
                }
                .listRowBackground(Color.clear)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.background))
                .cornerRadius(8)
                .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    let networkClient = DefaultNetworkClient(config: URLSessionConfiguration.default)
    let fetchUserDetailsUseCase = FetchUserDetailsUseCaseImpl(networkClient: networkClient)
    let fetchRepositoryUseCase = FetchRepositoryUseCaseImpl(networkClient: networkClient)
    
    let viewModel = UserDetailsViewModel(userLogin: "octocat", fetchUserDetailsUseCase: fetchUserDetailsUseCase, fetchRepositoryUseCase: fetchRepositoryUseCase)
    
    @State var navigationStack: [AppScreen] = []
    
    return UserDetailsScreen(viewModel: viewModel, navigationStack: $navigationStack)
}
