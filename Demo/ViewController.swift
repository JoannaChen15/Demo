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
        
        let letStruct = MyStruct(value: 10)
        letStruct.modifyValue(newVal: 20)
        letStruct.value = 20
        
        var varStruct = MyStruct(value: 10)
        varStruct.modifyValue(newVal: 20)
        
        modifyStruct(obj: varStruct)
        
        let letClass = MyClass(value: 10)
        letClass.modifyValue(newVal: 20)
        letClass.value = 20
        
        var varClass = MyClass(value: 20)
        
        modifyClass(obj: varClass)
    }
    
    func modifyStruct(obj: MyStruct) {
        obj.value = 100
    }
    
    func modifyClass(obj: MyClass) {
        obj.value = 100
    }
}

struct MyStruct {
    var value = 42

    // 在value type的方法中直接修改属性，需要 mutating 关键字
    mutating func modifyValue(newVal: Int) {
        value = newVal
    }
}

class MyClass {
    var value = 42

    // 在类的方法中直接修改属性，不需要 mutating 关键字
    func modifyValue(newVal: Int) {
        value = newVal
    }
    //
    init(value: Int = 42) {
        self.value = value
    }
}
//函數中struct當參數且會改變本身的值時，需要加inout
//呼叫函數時，參數前加&
class demo {
    func add_5(number: inout Int) -> Int {
        number += 5
        return number
    }
    
    func test() {
        var i = 3
        var result = add_5(number: &i)
    }
}
