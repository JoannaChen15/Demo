//
//  ClassPractice.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/20.
//

import Foundation

struct ClassPractice {
    func main() {
        //Dog
        let sunny: Dog = Dog(sex: "boy", color: "yellow")
        print(sunny.color)
        sunny.bark()
    }
}
