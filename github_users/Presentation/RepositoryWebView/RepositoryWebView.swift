//
//  WebView.swift
//  github_users
//
//  Created by Pritam Biswas on 12.07.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    private let webview = WKWebView()
    let url: URL
    
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            Logger.shared.log("Failed to load web view with error: \(error)", level: .error)
            parent.isLoading = false
            parent.error = error
        }
    }
}

struct RepositoryWebView: View {
    let url: String
    let name: String
    
    @State private var isLoading = true
    @State private var error: Error? = nil
    
    // Loading view
    private var loadingView: some View {
        HStack {
            Spacer()
            ProgressView("Loading...")
            .frame(width: 120, height: 120, alignment: .center)
            .font(.headline)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // Initial message when the list is empty
    private func makeErrorView(message: String) -> some View {
        Text(message)
            .font(.body)
            .foregroundStyle(.secondary)
            .padding()
    }
    
    var body: some View {
        ZStack {
            if let error = error {
                makeErrorView(message: error.localizedDescription)
            } else if let url = URL(string: url) {
                WebView(url: url,
                        isLoading: $isLoading,
                        error: $error
                )
                if isLoading {
                    loadingView
                }
            } else {
                makeErrorView(message: "Failed to load the url!")
            }
        }.navigationTitle(name)
    }
}

#Preview {
    @State var isLoading = false
    @State var error: Error? = nil
    
    return RepositoryWebView(
        url: "https://github.com/pritam-bs/github_users", name: "github_users")
}
