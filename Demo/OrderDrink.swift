//
//  OrderDrink.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/27.
//

import Foundation

// MARK: - CreateOrderDrink
struct CreateOrderDrink: Encodable {
    let records: [CreateOrderRecord]
}

// MARK: - Record
struct CreateOrderRecord: Encodable {
    let fields: CreateOrderFields
}

// MARK: - Fields
struct CreateOrderFields: Encodable {
    let drinkName, size, temperature, sugar: String
    let addOns: [String]
    let price: Int
    let orderName: String
    let numberOfCups: Int
    let imageUrl: URL
}


// MARK: - CreateOrderDrinkResponse
struct CreateOrderDrinkResponse: Decodable {
    let records: [CreateOrderDrinkResponseRecord]
}

// MARK: - Record
struct CreateOrderDrinkResponseRecord: Decodable {
    let id, createdTime: String
    let fields: CreateOrderDrinkResponseFields
}

// MARK: - Fields
struct CreateOrderDrinkResponseFields: Decodable {
    let orderName, drinkName, size, temperature, sugar : String
    let addOns: [String]?
    let price, numberOfCups: Int
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case price, size, addOns
        case imageURL = "imageUrl"
        case orderName, drinkName, sugar, numberOfCups, ice
    }
}
