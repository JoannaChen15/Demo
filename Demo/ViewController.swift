//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hw01 = HW01()
        hw01.main()
        
        let hw02 = HW02()
        hw02.main()
        let classPractice = ClassPractice()
        classPractice.main()
        
    }
}
