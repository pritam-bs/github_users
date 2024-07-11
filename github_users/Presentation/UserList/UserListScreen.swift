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
                makeEmptyView(message: message)
            case .initialWithError(let error):
                makeErrorView(error: error)
            default:
                contentView
            }
        }
        .navigationTitle("Users")
        .onAppear {
            viewModel.fetchUsers()
        }
    }
    
    private var loadingView: some View {
        HStack {
            Spacer()
            ProgressView("Loading...")
            .frame(width: 120, height: 120, alignment: .center)
            .font(.title)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func makeEmptyView(message: String) -> some View {
        Text(message)
    }
    
    private func makeErrorView(error: AppError) -> some View {
        Group {
            switch error {
            case .noInternet, .timeout:
                VStack {
                    Text(error.localizedDescription)
                    Button{
                        viewModel.fetchUsers()
                    } label: {
                        Text("Try again")
                    }
                }
            default:
                Text(error.localizedDescription)
            }
        }
    }
    
    private func makeUserListItem(user: User) -> some View {
        NavigationLink(value: AppScreen.userDetails(user)) {
            UserAvatarView(imageUrl: URL(string: user.avatarURL ?? ""))
                .frame(width: 40, height: 40)
            Text(user.login)
        }
    }
    
    private var contentView: some View {
        Logger.shared.log("contentView State: \(viewModel.state)", level: .debug)
        return List() {
            ForEach(viewModel.users) { user in
                makeUserListItem(user: user)
            }
            switch viewModel.state {
            case .loaded:
                loadingView
                    .onAppear {
                        viewModel.fetchUsers()
                    }
            case .loadingNext:
                loadingView
            case .error(let error):
                makeErrorView(error: error)
            default:
                EmptyView()
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    let networkClient = DefaultNetworkClient(config: URLSessionConfiguration.default)
    let fetchUsersUseCase = FetchUsersUseCaseImpl(networkClient: networkClient)
    let viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase)
    @State var navigationStack: [AppScreen] = []
    
    return UserListScreen(viewModel: viewModel, navigationStack: $navigationStack)
}
