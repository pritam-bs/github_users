//
//  UserDetailsDTO.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDetailsDTO = try? JSONDecoder().decode(UserDetailsDTO.self, from: jsonData)

import Foundation

// MARK: - UserDetailsDTO
// MARK: - UserDetailsDTO
struct UserDetailsDTO: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String?
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int
    let createdAt, updatedAt: String
    let privateGists: Int?
    let totalPrivateRepos: Int?
    let ownedPrivateRepos: Int?
    let diskUsage: Int?
    let collaborators: Int?
    let twoFactorAuthentication: Bool?
    let plan: Plan?
    let suspendedAt: String?
    let businessPlus: Bool?
    let ldapDn: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case privateGists = "private_gists"
        case totalPrivateRepos = "total_private_repos"
        case ownedPrivateRepos = "owned_private_repos"
        case diskUsage = "disk_usage"
        case collaborators
        case twoFactorAuthentication = "two_factor_authentication"
        case plan
        case suspendedAt = "suspended_at"
        case businessPlus = "business_plus"
        case ldapDn = "ldap_dn"
    }
    
    struct Plan: Codable {
        let collaborators: Int
        let name: String
        let space: Int
        let privateRepos: Int

        enum CodingKeys: String, CodingKey {
            case collaborators, name, space
            case privateRepos = "private_repos"
        }
    }
}
