//
//  RepositoryEntity.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct RepositoryEntity: Identifiable {
    let id: Int
    let name: String
    let language: String
    let stars: Int
    let description: String
    let url: String
    let fork: Bool
}

typealias RepositorysEntity = [RepositoryEntity]
