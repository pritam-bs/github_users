//
//  UserDetailsScreen.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import SwiftUI

struct UserDetailsScreen: View {
    
    struct RepositoryData: Identifiable {
        // Unique identifier for each instance
        let id = UUID()
        let url: String
        let name: String
    }
    
    @StateObject var viewModel: UserDetailsViewModel
    @Binding var navigationStack: [AppScreen]
    @State private var repositorySafariViewData: RepositoryData? = nil
    
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
        .sheet(item: $repositorySafariViewData) { data in
            RepositorySafariView(url: data.url, name: data.name)
                .presentationDetents([.large])
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
                Button(action: {
                    repositorySafariViewData = RepositoryData(url: repository.url, name: repository.name)
                }) {
                    RepositoryListItemView(repository: repository)
                }
                .buttonStyle(PlainButtonStyle())
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
    
    let userDetailsCacheManager = CacheManager<UserDetailsCacheKey, UserDetailsEntity>()
    let userDetailsCacheUseCase = UserDetailsCacheUseCaseImpl(cacheManager: userDetailsCacheManager)
    
    let repositoryCacheManager = CacheManager<RepositoryCacheKey, RepositoriesEntity>()
    let repositoryCacheUseCase = RepositoryCacheUseCaseImpl(cacheManager: repositoryCacheManager)
    
    let viewModel = UserDetailsViewModel(
        userLogin: "octocat",
        fetchUserDetailsUseCase: fetchUserDetailsUseCase,
        fetchRepositoryUseCase: fetchRepositoryUseCase,
        userDetailsCacheUseCase: userDetailsCacheUseCase,
        repositoryCacheUseCase: repositoryCacheUseCase
    )
    
    @State var navigationStack: [AppScreen] = []
    
    return UserDetailsScreen(viewModel: viewModel, navigationStack: $navigationStack)
}
