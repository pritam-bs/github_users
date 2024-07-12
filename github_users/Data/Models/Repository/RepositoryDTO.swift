//
//  RepositoryDTO.swift
//  github_users
//
//  Created by Pritam Biswas on 11.07.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let repositoryDTO = try? JSONDecoder().decode(RepositoryDTO.self, from: jsonData)

import Foundation

// MARK: - RepositoryDTO
struct RepositoryDTO: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let repositoryDTOPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let description: String?
    let fork: Bool
    let url: String
    let archiveURL, assigneesURL, blobsURL, branchesURL: String
    let collaboratorsURL, commentsURL, commitsURL, compareURL: String
    let contentsURL, contributorsURL, deploymentsURL, downloadsURL: String
    let eventsURL, forksURL, gitCommitsURL, gitRefsURL: String
    let gitTagsURL, hooksURL, issueCommentURL, issueEventsURL: String
    let issuesURL, keysURL, labelsURL, languagesURL: String
    let mergesURL, milestonesURL, notificationsURL, pullsURL: String
    let releasesURL, stargazersURL, statusesURL, subscribersURL: String
    let subscriptionURL, tagsURL, teamsURL, treesURL: String
    let cloneURL, gitURL, sshURL, svnURL: String
    let homepage: String?
    let size, stargazersCount, watchersCount: Int
    let language: String?
    let hasIssues, hasProjects, hasWiki, hasPages: Bool
    let hasDownloads, hasDiscussions: Bool
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
    let createdAt, updatedAt, pushedAt: String?
    let permissions: Permissions?
    let roleName: String?
    let tempCloneToken: String?
    let deleteBranchOnMerge: Bool?
    let subscribersCount: Int?
    let networkCount: Int?
    let codeOfConduct: CodeOfConduct?
    let securityAndAnalysis: SecurityAndAnalysis?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case repositoryDTOPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description, fork, url
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case hooksURL = "hooks_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDownloads = "has_downloads"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case topics, visibility, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case permissions
        case roleName = "role_name"
        case tempCloneToken = "temp_clone_token"
        case deleteBranchOnMerge = "delete_branch_on_merge"
        case subscribersCount = "subscribers_count"
        case networkCount = "network_count"
        case codeOfConduct = "code_of_conduct"
        case securityAndAnalysis = "security_and_analysis"
    }
}

// MARK: - License
struct License: Codable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String?
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL, receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    let name: String?
    let email: String?

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
        case name, email
    }
}

// MARK: - Permissions
struct Permissions: Codable {
    let admin, maintain, push, triage: Bool
    let pull: Bool
}

// MARK: - CodeOfConduct
struct CodeOfConduct: Codable {
    let key, name: String
    let url: String
    let body: String
    let htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case key, name, url, body
        case htmlURL = "html_url"
    }
}

// MARK: - SecurityAndAnalysis
struct SecurityAndAnalysis: Codable {
    let advancedSecurity, dependabotSecurityUpdates, secretScanning, secretScanningPushProtection: SecurityStatus?

    enum CodingKeys: String, CodingKey {
        case advancedSecurity = "advanced_security"
        case dependabotSecurityUpdates = "dependabot_security_updates"
        case secretScanning = "secret_scanning"
        case secretScanningPushProtection = "secret_scanning_push_protection"
    }
}

// MARK: - SecurityStatus
struct SecurityStatus: Codable {
    let status: String
}

typealias RepositoriesDTO = [RepositoryDTO]
