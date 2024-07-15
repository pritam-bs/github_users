//
//  BundleClass.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Foundation

class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}
