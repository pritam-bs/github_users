//
//  Repo.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let repos = try? JSONDecoder().decode(Repos.self, from: jsonData)

import Foundation

import Foundation

// MARK: - Repo
struct Repo: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let repoPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let description: String?
    let fork: Bool
    let url: String
    let forksURL: String
    let keysURL, collaboratorsURL: String
    let teamsURL, hooksURL: String
    let issueEventsURL: String
    let eventsURL: String
    let assigneesURL, branchesURL: String
    let tagsURL: String
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String
    let statusesURL: String
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String
    let subscriptionURL: String
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String
    let contentsURL, compareURL: String
    let mergesURL: String
    let archiveURL: String
    let downloadsURL: String
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String
    let labelsURL, releasesURL: String
    let deploymentsURL: String
    let createdAt, updatedAt, pushedAt: Date
    let gitURL, sshURL: String
    let cloneURL: String
    let svnURL: String
    let homepage: String?
    let size, stargazersCount, watchersCount: Int
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool
    let hasPages, hasDiscussions: Bool
    let forksCount: Int
    let mirrorURL: String?
    let archived, disabled: Bool
    let openIssuesCount: Int
    let license: License?
    let allowForking, isTemplate, webCommitSignoffRequired: Bool
    let topics: [String]
    let visibility: String
    let forks, openIssues, watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID
        case name
        case fullName
        case repoPrivate
        case owner
        case htmlURL
        case description, fork, url
        case forksURL
        case keysURL
        case collaboratorsURL
        case teamsURL
        case hooksURL
        case issueEventsURL
        case eventsURL
        case assigneesURL
        case branchesURL
        case tagsURL
        case blobsURL
        case gitTagsURL
        case gitRefsURL
        case treesURL
        case statusesURL
        case languagesURL
        case stargazersURL
        case contributorsURL
        case subscribersURL
        case subscriptionURL
        case commitsURL
        case gitCommitsURL
        case commentsURL
        case issueCommentURL
        case contentsURL
        case compareURL
        case mergesURL
        case archiveURL
        case downloadsURL
        case issuesURL
        case pullsURL
        case milestonesURL
        case notificationsURL
        case labelsURL
        case releasesURL
        case deploymentsURL
        case createdAt
        case updatedAt
        case pushedAt
        case gitURL
        case sshURL
        case cloneURL
        case svnURL
        case homepage, size
        case stargazersCount
        case watchersCount
        case language
        case hasIssues
        case hasProjects
        case hasDownloads
        case hasWiki
        case hasPages
        case hasDiscussions
        case forksCount
        case mirrorURL
        case archived, disabled
        case openIssuesCount
        case license
        case allowForking
        case isTemplate
        case webCommitSignoffRequired
        case topics, visibility, forks
        case openIssues
        case watchers
        case defaultBranch
    }
}

// MARK: - License
struct License: Codable {
    let key, name, spdxID: String
    let url: String
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID
        case url
        case nodeID
    }
}

// MARK: - Owner
struct Owner: Codable {
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
    }
}

typealias Repos = [Repo]
