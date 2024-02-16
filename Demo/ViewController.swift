//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit

class ViewController: UIViewController {
    let tabBar = UITabBarController()
    let home = HomeViewController()
    let profile = ProfileViewController()
    let postPage = PostPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBar.viewControllers = [home, profile, postPage]
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
