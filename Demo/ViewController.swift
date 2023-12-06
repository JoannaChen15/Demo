//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func filterFunc (oldArray:[Int], function: (Int) -> Bool) -> [Int]? {
            var result: [Int]?
            
            for i in oldArray {
                if function(i) {
                    if result == nil {
                        result = [Int]()
                    }
                result?.append(i)
                }
            }
            return result
        }
        
        let newArray = filterFunc(oldArray: numbers) { i in
            return i > 5
        }
        
        print(newArray ?? [])
    }
}
