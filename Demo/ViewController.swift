//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit
import Alamofire


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters: [String: Any] = [
            "name": "joanna",
            "job": "none"
        ]
        
        Alamofire.request("https://reqres.in/api/users", method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            if let data = response.data,
               let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data) {
                print("name:\(createUserResponse.name), job:\(createUserResponse.job), id:\(createUserResponse.id)")
            }
            print(response.timeline)
        }
    }
}
