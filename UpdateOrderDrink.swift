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
    let size: String
    let ice: String
    let sugar: String
    let addOns: [String]
    let price: Int
    let numberOfCups: Int
}
