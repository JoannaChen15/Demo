//
//  MyModel.swift
//  Demo
//
//  Created by 陳柔夆 on 2023/10/3.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
//struct MyModel: Codable {
//    let qotdDate: String
//    let quote: Quote
//
//    enum CodingKeys: String, CodingKey {
//        case qotdDate = "qotd_date"
//        case quote
//    }
//}
//
//// MARK: - Quote
//struct Quote: Codable {
//    let id: Int
//    let dialogue, quotePrivate: Bool
//    let tags: [String]
//    let url: String
//    let favoritesCount, upvotesCount, downvotesCount: Int
//    let author, authorPermalink, body: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, dialogue
//        case quotePrivate = "private"
//        case tags, url
//        case favoritesCount = "favorites_count"
//        case upvotesCount = "upvotes_count"
//        case downvotesCount = "downvotes_count"
//        case author
//        case authorPermalink = "author_permalink"
//        case body
//    }
//}

// MARK: - Welcome
struct MyModel: Codable {
    let data: DataClass
    let support: Support
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}

struct CreateUserBody: Encodable {
    let name: String
    let job: String
}

struct CreateUserResponse: Decodable {
    let name: String
    let job: String
    let id: String
}
