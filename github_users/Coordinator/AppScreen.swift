//
//  AppSteps.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation

enum AppScreen: Hashable {
    case userList
    case userDetails(User)
    case repositoryWebView(String, String)
}
