//
//  RepositorySafariView.swift
//  github_users
//
//  Created by Pritam Biswas on 12.07.2024.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No need to update the view controller as SFSafariViewController manages its own state
    }
}

struct RepositorySafariView: View {
    let url: String
    let name: String
    
    var body: some View {
        SafariView(url: URL(string: url)!)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle(name)
    }
}

#Preview {
    RepositorySafariView(
        url: "https://github.com/pritam-bs/github_users",
        name: "github_users"
    )
}
