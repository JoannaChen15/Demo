//
//  Drink.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import Foundation

// MARK: - Drink
struct Drink: Codable {
    let records: [Record]?
}

// MARK: - Record
struct Record: Codable {
//    let id: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let medium, large, description, name: String
    let image: [Image]
    let category: Category

//    enum CodingKeys: String, CodingKey {
//        case medium, large, description, name, image, category
//    }
}

enum Category: String, Codable {
    case classic = "單品茶"
    case seasonal = "季節限定"
    case milk = "歐蕾"
    case mix = "調茶"
    case cream = "雲蓋"
}

// MARK: - Image
struct Image: Codable {
//    let id: String
//    let width, height: Int
    let url: URL?
//    let filename: String
//    let size: Int
//    let type: TypeEnum
}

//// MARK: - Thumbnails
//struct Thumbnails: Codable {
//    let small, large, full: Full
//}
//
//// MARK: - Full
//struct Full: Codable {
//    let url: String
//    let width, height: Int
//}
//
//enum TypeEnum: String, Codable {
//    case imageJPEG = "image/jpeg"
//}
