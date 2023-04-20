//
//  Dog.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/20.
//

import Foundation

class Dog {
    let sex: String
    let color: String
    func bark() {
        print(String(repeating: "汪", count: 3))
    }
    
    init(sex: String, color: String) {
        self.sex = sex
        self.color = color
    }
}
