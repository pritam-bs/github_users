//
//  UserDetailsScreen.swift
//  github_users
//
//  Created by Pritam Biswas on 09.07.2024.
//

import Foundation
import SwiftUI

struct UserDetailsScreen: View {
    @StateObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        VStack {
            Text("User Details for \(viewModel.user.name)")
        }
        .navigationTitle("User Details")
    }
}
