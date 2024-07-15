//
//  UserListScreen.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import SwiftUI

struct UserListScreen: View {
    @ObservedObject var viewModel: UserListViewModel
    @Binding var navigationStack: [AppScreen]
        
    var body: some View {
        Logger.shared.log("State: \(viewModel.state)", level: .debug)
        return Group {
            switch viewModel.state {
            case .initial(let message):
                // Show the initial message
                makeEmptyView(message: message)
            case .initialWithError(let error):
                // Show the error view
                makeErrorView(error: error)
            default:
                // Default, show the content view
                contentView
            }
        }
        .navigationTitle("Users")
        .onAppear {
            if viewModel.users.isEmpty {
                viewModel.fetchUsers(since: 0)
            }
        }
    }
    
    // Loading view for fetching next page
    private var loadingView: some View {
        HStack {
            Spacer()
            ProgressView("Loading...")
            .frame(width: 120, height: 120, alignment: .center)
            .font(.headline)
            Spacer()
        }
        .listRowSeparator(.hidden)
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
            case .noInternet, .timeout, .networkError:
                VStack {
                    Text(error.localizedDescription)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    // Retry button
                    Button{
                        let id = viewModel.users.last?.id ?? 0
                        viewModel.fetchUsers(since: id)
                    } label: {
                        Text("Try again")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.blue)
                            .cornerRadius(4)
                            .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
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
        .listRowSeparator(.hidden)
    }
    
    // List item view
    private func makeUserListItem(user: UserEntity) -> some View {
        NavigationLink(value: AppScreen.userDetails(user)) {
            HStack(spacing: 16) {
                // User avatar
                UserAvatarView(imageUrl: URL(string: user.avatarURL ?? ""))
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                
                // User login
                Text(user.login)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.background))
        .cornerRadius(8)
        .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        
    }
    
    // Combine the list, loading view and error view as a list
    private var contentView: some View {
        Logger.shared.log("contentView State: \(viewModel.state)", level: .debug)
        return List() {
            ForEach(viewModel.users) { user in
                makeUserListItem(user: user)
                    .listRowBackground(Color.clear)
            }
            Group {
                switch viewModel.state {
                case .loaded:
                    loadingView
                        .onAppear {
                            if let id = viewModel.users.last?.id {
                                viewModel.fetchUsers(since: id)
                            }
                        }
                case .loadingNext:
                    loadingView
                case .error(let error):
                    makeErrorView(error: error)
                default:
                    EmptyView()
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    let networkClient = DefaultNetworkClient(config: URLSessionConfiguration.default)
    let fetchUsersUseCase = FetchUsersUseCaseImpl(networkClient: networkClient)
    
    let cacheManager = CacheManager<UsersCacheKey, UsersEntity>()
    let usersCacheUseCase = UsersCacheUseCaseImpl(cacheManager: cacheManager)
    
    let viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase, usersCacheUseCase: usersCacheUseCase)
    
    @State var navigationStack: [AppScreen] = []
    
    return UserListScreen(viewModel: viewModel, navigationStack: $navigationStack)
}
