//
//  RepositoryCacheKey.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

struct RepositoryCacheKey: Hashable, Equatable {
    let name: String
    let login: String
}
