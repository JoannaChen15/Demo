//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.secondary
        UITabBar.appearance().unselectedItemTintColor = UIColor.unselected
        UITabBar.appearance().barTintColor = .primary
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tabBar = UITabBarController()
        let menuNavigation = UINavigationController(rootViewController: MenuViewController.shared)
        let orderNavigation = UINavigationController(rootViewController: OrderViewController())
        
        tabBar.viewControllers = [menuNavigation, orderNavigation]
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }

}

