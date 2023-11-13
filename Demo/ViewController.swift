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
        
        var demo = Demo()
        demo.myFunction()
        
        print("viewDidLoad")
    }
}

class Demo {
    let world = "World"

    func myFunction() {
        sleep(2)
        print("Hello,")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            print(self?.world)
        })
    }

    deinit {
        print(#function)
    }
}
