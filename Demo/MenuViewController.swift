//
//  MenuViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import Kingfisher

class MenuViewController: UIViewController {
    
    let menuTableView = UITableView()
    var drinks = [Record]()
    var drinkImages = [Image]()
    
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
        // 設置導航欄背景色
        navigationController?.navigationBar.barTintColor = .primary
        
        configUI()
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(DrinkCell.self, forCellReuseIdentifier: "drinkCell")
        
        fetchDrinkData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 設置導航欄返回按鈕的文字
        navigationController?.navigationBar.tintColor = .secondary
        // 設置導航欄返回按鈕的顏色
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
    }
    
    func fetchDrinkData() {
        let urlString = "https://api.airtable.com/v0/appxrciNhGMQw3sSj/drink"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer patvAhzcinGLGQMUH.8c087e2edef8ee9df4e4a594218efbd6b3662092407055e81ed85e4aac1c2f9e", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            let decoder = JSONDecoder()
            do {
                let drink = try decoder.decode(Drink.self, from: data)
                self.drinks = drink.records ?? []
                for drink in self.drinks {
                    self.drinkImages.append(contentsOf: drink.fields.image)
                }
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func configUI() {
        view.backgroundColor = .primary
        configMenuTableView()
    }
    
    func configMenuTableView() {
        view.addSubview(menuTableView)
        menuTableView.backgroundColor = .primary
        menuTableView.separatorColor = .gray
        menuTableView.separatorInset.right = 16
        menuTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.row]
        cell.drinkName.text = drink.fields.name
        cell.drinkDescription.text = drink.fields.description
        cell.drinkPrice.text = "中：\(drink.fields.medium) / 大：\(drink.fields.large)"
        cell.drinkImageView.kf.setImage(with: drinkImages[indexPath.row].url)
        
        return cell
    }
}
