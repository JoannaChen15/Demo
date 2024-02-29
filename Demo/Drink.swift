//
//  Drink.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import Foundation

// MARK: - Drink
struct Drink: Decodable {
    let records: [Record]?
}

// MARK: - Record
struct Record: Decodable {
    let fields: Fields
}

// MARK: - Fields
struct Fields: Decodable {
    let name, description: String
    let medium, large: Int
    let image: [Image]
    let category: Category
}

enum Category: String, Decodable {
    case classic = "單品茶"
    case seasonal = "季節限定"
    case milk = "歐蕾"
    case mix = "調茶"
    case cream = "雲蓋"
}

// MARK: - Image
struct Image: Decodable {
    let url: URL?
}
