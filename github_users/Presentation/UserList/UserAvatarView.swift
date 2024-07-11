//
//  UserAvatarView.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import SwiftUI

struct UserAvatarView: View {
    var imageUrl: URL?
    
    private var fallbackImage: some View {
        let randomizedColor: Color = [.blue, .green, .red, .orange, .purple].shuffled().first!
        return Image(systemName: "person.crop.circle")
            .resizable()
            .foregroundColor(randomizedColor)
    }
    
    var body: some View {
        ZStack {
            if let imageUrl {
                AsyncImage(url: imageUrl) { state in
                    if let image = state.image {
                        image.resizable()
                    } else if state.error != nil {
                        fallbackImage
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            } else {
                fallbackImage
            }
        }
        .aspectRatio(contentMode: .fill)
        .clipShape(Circle())
        .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let url = URL(string: "https://avatars.githubusercontent.com/u/45875515?v=4")
    return UserAvatarView(imageUrl: nil)
        .padding()
        .frame(width: 200, height: 200)
}
