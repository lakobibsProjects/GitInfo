//
//  RepoByLogin.swift
//  GitInfo
//
//  Created by user166683 on 8/25/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

// MARK: - RepoResponse
struct Repos: Decodable{
    var repos: [RepoResponse]
    
    enum CodingKeys: String, CodingKey {
        case repos = ""
    }
}

struct RepoResponse: Decodable {
    var id: Int?
    var name: String?
    var updatedAt: Date?
    var stargazersCount: Int?
    var language: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case language
    }
}
