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

// MARK: - CreateOrderRecord
struct CreateOrderRecord: Encodable {
    let fields: CreateOrderFields
}

// MARK: - CreateOrderFields
struct CreateOrderFields: Codable {
    let drinkName: String
    let size: String
    let ice: String
    let sugar: String
    let addOns: [String]?
    let price: Int
    let orderName: String
    let numberOfCups: Int
    let imageUrl: URL
}


// MARK: - CreateOrderDrinkResponse
struct CreateOrderDrinkResponse: Decodable {
    let records: [CreateOrderDrinkResponseRecord]
}

// MARK: - CreateOrderDrinkResponseRecord
struct CreateOrderDrinkResponseRecord: Decodable {
    let id: String
    let createdTime: String
    let fields: CreateOrderFields
}
