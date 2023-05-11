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
        let lab = UILabel()
        lab.text = "XXXX"
        view.addSubview(lab)
        lab.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tabBar = UITabBarController()
        let red = RedViewController()
        let blue = BlueViewController()
        tabBar.viewControllers = [red, blue]
        tabBar.view.alpha = 0.3
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.backgroundColor = .white
        present(tabBar, animated: true, completion: nil)
    }
}


class RedViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Red",
                                  image: UIImage(systemName: "house"),
                                  selectedImage: UIImage(systemName: "house.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class BlueViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Blue",
                                  image: UIImage(systemName: "house"),
                                  selectedImage: UIImage(systemName: "house.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
