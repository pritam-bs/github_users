//
//  JsonLoader.swift
//  github_usersTests
//
//  Created by Pritam Biswas on 15.07.2024.
//

import Foundation

class JsonLoader {
    func load<T: Decodable>(filename: String, as type: T.Type) -> T? {
        
        let path = BundleClass().bundle.path(forResource: filename, ofType: "json")
        
        let mockData = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        
        if let data = mockData {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Error loading JSON from \(filename): \(error)")
            }
        }
        return nil
    }
}
