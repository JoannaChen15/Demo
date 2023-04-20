//
//  HW01.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/20.
//

import Foundation

struct HW01 {
    func main() {
        let numberOfAdults = 20
        let numberOfKids = 30
        let total = numberOfAdults + numberOfKids
        print("The total party size is: \(total)")

        let baseSalary = 5000
        let bonusAmount = 1000
        let totalSalary = "\(baseSalary) + \(bonusAmount)"
        print("Congratulations for your bonus! You will receive a total of \(totalSalary)(additional bonus).")
        
        // class 應該移出去與 struct 同層
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

        let sunny: Dog = Dog(sex: "boy", color: "yellow")
        print(sunny.color)
        sunny.bark()
    }
}


