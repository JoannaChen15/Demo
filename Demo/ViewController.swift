//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let tabBar = UITabBarController()
    let home = HomeViewController()
    let profile = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBar.viewControllers = [home, profile]
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
