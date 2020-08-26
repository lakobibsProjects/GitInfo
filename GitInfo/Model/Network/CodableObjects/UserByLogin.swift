//
//  UserByLogin.swift
//  GitInfo
//
//  Created by user166683 on 8/24/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

struct UserByLogin: Decodable {
    var login: String?
    var id: Int
    var avatarURL: String
    var name: String?
    var location: String?
    var createdAt: Date

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case name
        case location
        case createdAt = "created_at"
    }
}
