//
//  GetSearchresultByName.swift
//  GitInfo
//
//  Created by user166683 on 8/22/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - AccountSearch
struct AccountSearch: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let accounts: [SearchedAccount]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case accounts = "items"
    }
}

// MARK: - Item
struct SearchedAccount: Codable {
    let login: String
    let id: Int
    let avatarURL: String
    let url: String
    let reposURL: String
    let type: AccountType

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case url
        case reposURL = "repos_url"
        case type
    }
}

enum AccountType: String, Codable {
    case user = "User"
    case organization = "Organization"
}
