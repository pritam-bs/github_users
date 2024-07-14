//
//  UsersCacheKey.swift
//  github_users
//
//  Created by Pritam Biswas on 13.07.2024.
//

import Foundation

struct UsersCacheKey: Hashable, Equatable {
    let key: String
    let since: Int
}
