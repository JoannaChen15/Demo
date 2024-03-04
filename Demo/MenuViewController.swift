//
//  MenuViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import Kingfisher

class MenuViewController: UIViewController {
    static let shared = MenuViewController()
    
    let menuTableView = UITableView()
    var drinks = [Record]()
    var drinksOfSelectedCategory = [Record]()
    
    let baseURL = URL(string: "https://api.airtable.com/v0/appxrciNhGMQw3sSj")!
    let apiKey = "patvAhzcinGLGQMUH.8c087e2edef8ee9df4e4a594218efbd6b3662092407055e81ed85e4aac1c2f9e"
    
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
        navigationController?.navigationBar.barTintColor = .darkPrimary
        
        configUI()
        // 註冊自定義的 table header
        menuTableView.register(MenuHeaderView.self, forHeaderFooterViewReuseIdentifier: "menuHeader")
        fetchDrinkData()
        
    }
    
    func fetchDrinkData() {
        let drinkURL = baseURL.appendingPathComponent("Drink")
        var request = URLRequest(url: drinkURL)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let decoder = JSONDecoder()
                let drink = try decoder.decode(Drink.self, from: data)
                self.drinks = drink.records ?? []
                for drink in self.drinks {
                    if drink.fields.category == Category.seasonal {
                        self.drinksOfSelectedCategory.append(drink)
                    }
                }
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchOrderList(completion: @escaping (Result<CreateOrderDrinkResponse, Error>) -> Void) {
        let OrderListURL = baseURL.appendingPathComponent("OrderDrink")
        var request = URLRequest(url: OrderListURL)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let orderListResponse = try jsonDecoder.decode(CreateOrderDrinkResponse.self, from: data)
                    completion(.success(orderListResponse))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func postOrder(orderData: CreateOrderDrink, completion: @escaping (Result<String,Error>) -> Void) {
        let orderURL = baseURL.appendingPathComponent("OrderDrink")
        guard let components = URLComponents(url: orderURL, resolvingAgainstBaseURL: true) else { return }
        guard let orderURL = components.url else { return }
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(orderData)
            URLSession.shared.dataTask(with: request) { data, response, resError in
                if let data = data,
                   let content = String(data: data, encoding: .utf8) {
                    completion(.success(content))
                } else if let resError = resError {
                    completion(.failure(resError))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - DELETE Order
    func deleteOrder(orderID: String, completion: @escaping(Result<String,Error>) -> Void) {
        var orderURL = baseURL.appendingPathComponent("OrderDrink")
        orderURL = orderURL.appendingPathComponent(orderID)
        guard let components = URLComponents(url: orderURL, resolvingAgainstBaseURL: true) else { return }
        guard let orderURL = components.url else { return }
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, resError in
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               resError == nil,
               let data = data,
               let content = String(data: data, encoding: .utf8) {
                completion(.success(content))
            } else if let resError = resError {
                completion(.failure(resError))
            }
        }.resume()
    }

    func configUI() {
        view.backgroundColor = .darkPrimary
        configMenuTableView()
    }
    
    func configMenuTableView() {
        view.addSubview(menuTableView)
        menuTableView.backgroundColor = .darkPrimary
        menuTableView.separatorColor = .unselected
        menuTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        menuTableView.sectionHeaderTopPadding = 0
        menuTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(DrinkCell.self, forCellReuseIdentifier: "drinkCell")
        menuTableView.register(BannerCell.self, forCellReuseIdentifier: "BannerCell")
//        menuTableView.
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : drinksOfSelectedCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerCell
            return cell
        } else {
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkCell
            let drink = drinksOfSelectedCategory[indexPath.row]
            
            cell.drinkName.text = drink.fields.name
            cell.drinkDescription.text = drink.fields.description
            cell.drinkPrice.text = "中：\(drink.fields.medium) / 大：\(drink.fields.large)"
            cell.drinkImageView.kf.setImage(with: drink.fields.image.first?.url)
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkDetailVC = DrinkDetailViewController()
        drinkDetailVC.drink = drinksOfSelectedCategory[indexPath.row]
        present(drinkDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section > 0 else {
            return nil
        }
        let headerView = menuTableView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeader") as! MenuHeaderView
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section > 0 else {
            return 0
        }
        return 46
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section > 0 else { return nil }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section > 0 else { return 0 }
        let numberOfRow = tableView.numberOfRows(inSection: section)
        return CGFloat(120) * max(CGFloat.zero, CGFloat(5 - numberOfRow)) + 30
    }
}

extension MenuViewController: CategoryButtonDelegate {
    func changeMenuTo(category: String) {
        drinksOfSelectedCategory.removeAll()
        for drink in drinks {
            if drink.fields.category.rawValue == category {
                drinksOfSelectedCategory.append(drink)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.menuTableView.reloadData()
        }
    }
}
