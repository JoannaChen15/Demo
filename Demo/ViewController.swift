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
        
        let group = DispatchGroup()
        
        group.enter()
        print(Thread.current)
        let taskA = URLSession.shared.dataTask(with: URL(string: "https://reqres.in/api/users/1")!) { (data, response, error) in
            print(Thread.current)
            if let data = data {
                print("responseA")
            } else {
                print("error")
            }
            group.leave()
        }
        taskA.resume()
        print("request a")
        
        group.wait()
        
        group.enter()
        print(Thread.current)
        let taskB = URLSession.shared.dataTask(with: URL(string: "https://reqres.in/api/unknown/5")!) { (data, response, error) in
            print(Thread.current)
            if let data = data {
                print("responseB")
            } else {
                print("error")
            }
            group.leave()
        }
        taskB.resume()
        print("request b")
        
        group.notify(queue: DispatchQueue.global()) {
            print("fetch done")
        }
        print("executed")
    }
}
