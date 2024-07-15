
  

# GitHub Users Browser

  

## Overview

This project is an iOS native application built in SwiftUI that allows users to browse GitHub users and their repositories. It leverages the GitHub API to fetch user and repository data. The project follows the MVVM-C (Model-View-ViewModel-Coordinator) architecture along with Clean Architecture principles.

  

## Features

- Display a list of GitHub users with their avatars and usernames.

- Navigate to a detailed view of a user, showing their avatar, username, full name, number of followers, and followings.

- Display a list of the user's original (non-forked) repositories with the repository name, programming language, number of stars, and description.

- Open the repository URL in a SafariView when a repository is selected.

- Authentication using a personal access token.

- Pagination support for user lists.

- Error handling and user feedback for network issues.

- Unit tests for ViewModels and Use Cases.

- In-memory cache for user lists and user details.

- Caching of user avatar images.

  

## Installation

1. Clone the repository:

```bash

git clone https://github.com/yourusername/github_users.git

cd github_users

```

2. Install dependencies using Swift Package Manager.

3. Open the project in Xcode:

```bash

open github_users.xcodeproj

```

4. Set the `GITHUB_ACCESS_TOKEN` as an environment variable to handle authenticated requests and avoid the rate limit of 60 requests per hour:

- In Xcode, go to your scheme settings (Product > Scheme > Edit Scheme...).

- Select the "Run" action and go to the "Arguments" tab.

- Add a new environment variable with the name `GITHUB_ACCESS_TOKEN` and set its value to your GitHub personal access token.

  

## Folder Structure

```
github_users
├── Core
│   ├── NetworkMonitor
│   │   └── NetworkMonitor
│   ├── Logger
│       └── Logger
├── Infrastructure
│   ├── Cache
│   │   └── CacheManager
│   ├── Network
│       ├── NetworkClient
│       └── NetworkError
├── Data
│   ├── CacheRepositories
│   │   ├── UsersCacheUseCaseImpl
│   │   ├── UserDetailsCacheUseCaseImpl
│   │   └── RepositoryCacheUseCaseImpl
│   ├── Models
│   │   ├── UserDetails
│   │   │   ├── UserDetailsDTO
│   │   │   ├── UserDetailsMapper
│   │   │   └── UserDetailsCacheKey
│   │   ├── Repository
│   │   │   ├── RepositoryDTO
│   │   │   ├── RepositoryMapper
│   │   │   └── RepositoryCacheKey
│   │   └── Users
│   │       ├── UserDTO
│   │       ├── UserMapper
│   │       └── UsersCacheKey
│   ├── Protocol
│   │   ├── NetworkClient
│   │   └── CacheCodableManagerProtocol
│   └── Repositories
│       ├── FetchUsersUseCaseImpl
│       ├── FetchUserDetailsUseCaseImpl
│       └── FetchRepositoryUseCaseImpl
├── Domain
│   ├── UseCases
│   │   ├── FetchUsersUseCase
│   │   ├── FetchUserDetailsUseCase
│   │   ├── FetchRepositoryUseCase
│   │   ├── UsersCacheUseCase
│   │   ├── UserDetailsCacheUseCase
│   │   └── RepositoryCacheUseCase
│   ├── Entities
│       ├── AppError
│       ├── UserEntity
│       ├── RepositoryEntity
│       └── UserDetailsEntity
├── Presentation
│   ├── RepositoryWebView
│   │   └── RepositorySafariView
│   ├── UserAvatar
│   │   └── UserAvatarView
│   ├── UserList
│   │   ├── UserListViewModel
│   │   ├── UserListScreen
│   │   └── UserOrderedSet
│   ├── UserDetails
│   │   ├── UserDetailsViewModel
│   │   ├── UserDetailsScreen
│   │   └── UserView
│       └── RepositoryListItemView
│   ├── Coordinator
│       ├── AppScreen
│       ├── CoordinatorView
│       └── GithubUsersApp
```

  

## Libraries Used

- ****Kingfisher****: Used for efficient image downloading and caching to display user avatars.

  

## Getting Started

1. Run the application on your preferred simulator or physical device.

2. The initial screen will display a list of GitHub users.

3. Tap on a user to navigate to the User Repository Screen, which shows detailed information about the user and their repositories.

4. Tap on any repository to open its URL in a SafariView.

  

## Future Improvements

- Enhance the UI/UX with more animations and transitions.

- Better formatting of numbers for followers and following.

- Implement efficient network connectivity checks.

  

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
