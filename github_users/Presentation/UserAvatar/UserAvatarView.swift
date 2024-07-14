//
//  UserAvatarView.swift
//  github_users
//
//  Created by Pritam Biswas on 10.07.2024.
//

import Kingfisher
import SwiftUI

struct UserAvatarView: View {
    var imageUrl: URL?
    @State private var loadImageFailed = false
    
    private var fallbackImage: some View {
        let randomizedColor: Color = [.blue, .green, .red, .orange, .purple].shuffled().first!
        return Image(systemName: "person.crop.circle")
            .resizable()
            .foregroundColor(randomizedColor)
    }
    
    var body: some View {
        Group {
            if let imageUrl, !loadImageFailed {
                KFImage(imageUrl)
                    .resizable()
                    .onFailure { _ in
                        loadImageFailed = true
                    }
                    .placeholder {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .cancelOnDisappear(true)
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
    return UserAvatarView(imageUrl: nil)
        .padding()
        .frame(width: 200, height: 200)
}
