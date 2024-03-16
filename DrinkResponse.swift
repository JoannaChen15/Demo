//
//  Drink.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import Foundation

// MARK: - DrinkResponse
struct DrinkResponse: Decodable {
    let records: [DrinkRecord]
}

// MARK: - DrinkRecord
struct DrinkRecord: Decodable {
    let fields: DrinkFields
}

// MARK: - DrinkFields
struct DrinkFields: Decodable {
    let name: String
    let description: String
    let medium: Int
    let large: Int
    let image: [DrinkImage]
    let category: Category
}

enum Category: String, Decodable {
    case classic = "單品茶"
    case seasonal = "季節限定"
    case milk = "歐蕾"
    case mix = "調茶"
    case cream = "雲蓋"
}

// MARK: - DrinkImage
struct DrinkImage: Decodable {
    let url: URL
}
