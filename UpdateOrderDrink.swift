//
//  UpdateOrderDrink.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/5.
//

import Foundation

// MARK: - PatchOrderDrink
struct UpdateOrderDrink: Encodable {
    let records: [UpdateOrderRecord]
}

// MARK: - Record
struct UpdateOrderRecord: Encodable {
    let id: String
    let fields: UpdateOrderFields
}

// MARK: - Fields
struct UpdateOrderFields: Encodable {
    let size, ice, sugar: String
    let addOns: [String]
    let price: Int
    let numberOfCups: Int
}


// MARK: - UpdateOrderDrinkResponse
struct UpdateOrderDrinkResponse: Decodable {
    let records: [UpdateOrderDrinkResponseRecord]
}

// MARK: - Record
struct UpdateOrderDrinkResponseRecord: Decodable {
    let id, UpdatedTime: String
    let fields: UpdateOrderDrinkResponseFields
}

// MARK: - Fields
struct UpdateOrderDrinkResponseFields: Decodable {
    let orderName, drinkName, size, ice, sugar : String
    let addOns: [String]?
    let price, numberOfCups: Int
    let imageUrl: URL
}
