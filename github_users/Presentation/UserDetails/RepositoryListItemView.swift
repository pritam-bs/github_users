//
//  RepositoryListItemView.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import SwiftUI

struct RepositoryListItemView: View {
    var repository: RepositoryEntity
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    // Repository Name
                    Text(repository.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    // Number of Stars
                    Text("⭐️ \(repository.stars)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Programming Language
                Text("Language: \(repository.language)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                // Description
                Text(repository.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.background))
            .cornerRadius(8)
            .shadow(color: .primary.opacity(0.1), radius: 6, y: 4)
        }
}

#Preview {
    let repository = RepositoryEntity(
        id: 1,
        name: "Hello-World",
        language: "Swift",
        stars: 42,
        description: "This is a sample description of the repository."
    )
    return RepositoryListItemView(repository: repository)
}
