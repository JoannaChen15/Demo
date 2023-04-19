//
//  HW01.swift
//  Demo
//
//  Created by Tan Elijah on 2023/4/19.
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
    }
}
