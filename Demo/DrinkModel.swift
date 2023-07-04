//
//  DrinkModel.swift
//  Demo
//
//  Created by 譚培成 on 2023/7/3.
//

import Foundation

// MARK: - NapTea
struct NapTea: Codable {
    let records: [Record]
    
    // MARK: - Record
    struct Record: Codable {
        let id, createdTime: String
        let fields: Fields
    }
}

// MARK: - Fields
struct Fields: Codable {
    let price, description, name: String
    let image: [Image]

    enum CodingKeys: String, CodingKey {
        case price, description
        case name = "Name"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: String
    let width, height: Int
}
