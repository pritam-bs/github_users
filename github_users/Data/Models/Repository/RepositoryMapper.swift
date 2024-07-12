//
//  RepositoryMapper.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

import Foundation

struct RepositoryMapper {
    static func map(dto: RepositoryDTO) -> RepositoryEntity {
        return RepositoryEntity(
            id: dto.id,
            name: dto.name,
            language: dto.language ?? "Unknown", // Default to "Unknown" if language is nil
            stars: dto.stargazersCount,
            description: dto.description ?? "No description" // Default to "No description" if description is nil
        )
    }
    
    static func map(dto: RepositorysDTO) -> RepositorysEntity {
        return dto.map { map(dto: $0) }
    }
}
