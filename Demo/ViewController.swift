//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var square = Square(height: 5.0)
        print(square.area)
        
        square.area = 9.0
        print(square.height)
    }
}

struct Square {
    var height: Double
    var area: Double {
        get {
            return height * height
        }
        set {
            height = sqrt(newValue)
        }
    }
}
