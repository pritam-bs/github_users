//
//  UserView.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import SwiftUI

struct UserView: View {
    var userDetails: UserDetailsEntity
        
        var body: some View {
            VStack(alignment: .center, spacing: 4) {
                // Avatar Image
                UserAvatarView(imageUrl: URL(string: userDetails.avatarURL))
                    .frame(width: 100, height: 100)
                
                // Username
                Text("@\(userDetails.username)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                // Full Name
                if let name = userDetails.fullName {
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                // Followers and Followings
                HStack {
                    VStack {
                        Text("\(userDetails.followers)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text("Followers")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("\(userDetails.followings)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text("Followings")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .padding()
            .background(Color(.background))
            .cornerRadius(16)
            .shadow(color: .primary.opacity(0.2), radius: 6, y: 4)
        }
}

#Preview {
    let userDetails = UserDetailsEntity(
        avatarURL: "https://avatars.githubusercontent.com/u/583231?v=4",
        username: "octocat",
        fullName: "The Octocat",
        followers: 20,
        followings: 0
    )
    
    return UserView(userDetails: userDetails)
}
