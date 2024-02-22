//
//  OrderViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit

class OrderViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart"))
        tabBarItem.badgeColor = .secondary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
}
