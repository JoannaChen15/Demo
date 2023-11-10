//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Foundation
import Dispatch

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let incrementByTwo = makeIncrementer(incrementAmount: 2)
        print(incrementByTwo)  // 输出 2
        print(incrementByTwo)  // 输出 2
        
        let incrementByFour = makeIncrementerWithReturnClosure(incrementAmount: 4)
        print(incrementByFour())  // 输出 4
        print(incrementByFour())  // 输出 8

    }
}

func makeIncrementer(incrementAmount: Int) -> Int {
    var total = 0
    total += incrementAmount
    return total
}

func makeIncrementerWithReturnClosure(incrementAmount: Int) -> () -> Int {
    var total = 0

    let incrementer: () -> Int = {
        total += incrementAmount
        return total
    }

    return incrementer
}
