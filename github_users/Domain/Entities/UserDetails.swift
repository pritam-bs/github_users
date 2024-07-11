//
//  UserDetails.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? JSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - UserDetails
struct UserDetails: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    let name, company: String
    let blog: String
    let location: String
    let email, hireable, bio, twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int
    let createdAt, updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID
        case avatarURL
        case gravatarID
        case url
        case htmlURL
        case followersURL
        case followingURL
        case gistsURL
        case starredURL
        case subscriptionsURL
        case organizationsURL
        case reposURL
        case eventsURL
        case receivedEventsURL
        case type
        case siteAdmin
        case name, company, blog, location, email, hireable, bio
        case twitterUsername
        case publicRepos
        case publicGists
        case followers, following
        case createdAt
        case updatedAt
    }
}
