//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var person = Person(name: "Joanna", age: 28)
    //swift 4.0 引入更现代、类型安全的 KVO 机制
    var observation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        //kvc (Objective-C)
        person.setValue("Elijah", forKey: "name")
        print(person.value(forKey: "name")!)

        //kvo (Objective-C)
        var cat = Animal(type: "cat")
        person.addObserver(cat, forKeyPath: "name",options: [.old, .new], context: nil)
        //觸發func observeValue
        person.name = "Emily"
        person.removeObserver(cat, forKeyPath: "name")
        
        //observe (swift 4.0)
        observation = person.observe(\.name, options: [.old, .new]) { (object, change) in
            // 处理属性变化
            print("name change from \(change.oldValue!) to \(change.newValue!)")
            print(object.name)
        }
        person.name = "Joanna"
        
            
        //keyPath
        print(person[keyPath: \Person.name])
    }
}

class Person: NSObject {
    @objc dynamic var name: String
    @objc dynamic var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Animal: NSObject {
    var type: String
    init(type: String) {
        self.type = type
    }
    //實作func observeValue (Objective-C)
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "name" {
            if let oldValue = change?[.oldKey] as? String,
               let newValue = change?[.newKey] as? String {
                print("name change from \(oldValue) to \(newValue)")
            }
        }
    }
}
