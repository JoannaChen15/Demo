//
//  MenuViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    
    let menuTableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Drink", image: UIImage(systemName: "wineglass"), selectedImage: UIImage(systemName: "wineglass"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置 navigationItem 圖像
        let imageView = UIImageView(image: UIImage(named: "logo-m"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        configUI()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(DrinkCell.self, forCellReuseIdentifier: "drinkCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 設置導航欄返回按鈕的文字
        navigationController?.navigationBar.tintColor = .secondary
        // 設置導航欄返回按鈕的顏色
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
        

    }
    
    func configUI() {
        view.backgroundColor = .primary
    }
    
    func config() {
        
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
