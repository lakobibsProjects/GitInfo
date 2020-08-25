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
    var location: String
    var createdAt: Date
    //var nodeID: String?
    
    /*var gravatarID: String?
    var url, htmlURL, followersURL: String?
    var followingURL, gistsURL, starredURL: String?
    var subscriptionsURL, organizationsURL, reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?
    , company: String?
    var blog: String?
    
    //var email, hireable: JSONNull?
    //var bio: String?
    //var twitterUsername: JSONNull?
    var publicRepos, publicGists, followers, following: Int?
    //var createdAt, updatedAt: Date?*/

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
        case name
        case location
        case createdAt = "created_at"
        //case nodeID = "node_id"
        /*case gravatarID = "gravatar_id"
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
        case name, company, blog, location//, email, hireable, bio
        //case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        
        case updatedAt = "updated_at"*/
    }
}
/*
// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
*/
