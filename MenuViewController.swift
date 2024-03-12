//
//  MenuViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import Kingfisher
import Firebase

class MenuViewController: UIViewController {
    
    static let shared = MenuViewController()
    
    let mainLoginViewController = MainLoginViewController()
    
    let mainScrollView = UIScrollView()
    
    let bannerView = UIView()
    let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var bannerImages = [UIImage]()
    let bannerPageControl = UIPageControl()
    
    let menuTableView = UITableView()
    var drinks = [Record]()
    var drinksOfselectedCategory = [Record]()
    
    let baseURL = URL(string: "https://api.airtable.com/v0/appxrciNhGMQw3sSj")!
    let apiKey = "patvAhzcinGLGQMUH.8c087e2edef8ee9df4e4a594218efbd6b3662092407055e81ed85e4aac1c2f9e"
    
    var hasDisplayedLogin = false // 用來標記是否已經顯示過 MainLoginViewController
    var userName: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Drink", image: UIImage(systemName: "wineglass"), selectedImage: UIImage(systemName: "wineglass"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        mainScrollView.delegate = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: "bannerImageCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        bannerCollectionView.collectionViewLayout = layout
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(DrinkCell.self, forCellReuseIdentifier: "drinkCell")
        
        // 註冊自定義的 table header
        menuTableView.register(MenuHeaderView.self, forHeaderFooterViewReuseIdentifier: "menuHeader")
        fetchDrinkData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hasDisplayedLogin { // 如果還沒有顯示過 MainLoginViewController
            
            let mainLoginViewController = MainLoginViewController()
            mainLoginViewController.onLoginSuccess = { [weak self] userName in
                self?.userName = userName
            }
            mainLoginViewController.modalPresentationStyle = .fullScreen
            present(mainLoginViewController, animated: true)
            
            hasDisplayedLogin = true // 設置為已經顯示過
        }
    }
    
    @objc func logout() {
        // 自定義按鈕點擊事件處理
        let mainLoginViewController = MainLoginViewController()
        mainLoginViewController.onLoginSuccess = { [weak self] userName in
            self?.userName = userName
        }
        mainLoginViewController.modalPresentationStyle = .fullScreen
        present(mainLoginViewController, animated: true)
        hasDisplayedLogin = true // 設置為已經顯示過
        // Firebase登出
        do {
           try Auth.auth().signOut()
        } catch {
           print(error)
        }
    }
    
    // MARK: - GET Drink
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
                        self.drinksOfselectedCategory.append(drink)
                    }
                }
                DispatchQueue.main.async {
                    self.menuTableView.reloadData()
                    let contentHeight = self.menuTableView.bounds.height + (self.bannerView.bounds.height * 2)
                    self.mainScrollView.contentSize = CGSize(width: self.view.bounds.width, height: contentHeight)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - GET Order
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
    
    // MARK: - POST Order
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

    // MARK: - PATCH Order
    func updateOrder(orderData: UpdateOrderDrink, completion: @escaping (Result<String, Error>) -> Void) {
        let orderURL = baseURL.appendingPathComponent("OrderDrink")
        guard let components = URLComponents(url: orderURL, resolvingAgainstBaseURL: true) else { return }
        guard let orderURL = components.url else { return }

        var request = URLRequest(url: orderURL)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
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
    
    func configUI() {
        view.backgroundColor = .darkPrimary
        setBannerImages()
        configNavigationBar()
        configMainScrollView()
        configBannerView()
        configBannerCollectionView()
        configBannerPageControl()
        configMenuTableView()
    }
    
    func setBannerImages() {
        bannerImages.append(UIImage(named: "banner_0")!)
        bannerImages.append(UIImage(named: "banner_1")!)
        bannerImages.append(UIImage(named: "banner_2")!)
        bannerImages.append(UIImage(named: "banner_3")!)
        bannerImages.append(UIImage(named: "banner_4")!)
        bannerImages.append(UIImage(named: "banner_5")!)
    }
    
    func configNavigationBar() {
        // 設置navigationBar背景色
        navigationController?.navigationBar.barTintColor = .darkPrimary
        // 自訂navigationItem
        let navigationItemTitleView = UIView()
        navigationItemTitleView.snp.makeConstraints { make in
            make.height.equalTo(navigationController?.navigationBar.bounds.height ?? 0)
            make.width.equalTo(navigationController?.navigationBar.bounds.width ?? 0)
        }
        
        let imageView = UIImageView(image: UIImage(named: "logo-m"))
        navigationItemTitleView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        let logoutButton = UIButton()
        navigationItemTitleView.addSubview(logoutButton)
        logoutButton.setTitle("登出", for: .normal)
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        logoutButton.layer.cornerRadius = 16
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(32)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        navigationItem.titleView = navigationItemTitleView
    }
    
    func configMainScrollView() {
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        mainScrollView.bounces = false
    }
    
    func configBannerView() {
        mainScrollView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.contentLayoutGuide)
            make.left.right.equalTo(mainScrollView.frameLayoutGuide)
        }
    }
   
    func configBannerCollectionView() {
        bannerView.addSubview(bannerCollectionView)
        bannerCollectionView.backgroundColor = .clear
        bannerCollectionView.isPagingEnabled = true // 啓用分頁效果
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(230)
        }
    }
    
    func configBannerPageControl() {
        bannerView.addSubview(bannerPageControl)
        bannerPageControl.numberOfPages = bannerImages.count
        bannerPageControl.currentPage = 0
        bannerPageControl.pageIndicatorTintColor = .unselected
        bannerPageControl.currentPageIndicatorTintColor = .secondary
        bannerPageControl.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(25)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configMenuTableView() {
        mainScrollView.addSubview(menuTableView)
        menuTableView.backgroundColor = .darkPrimary
        menuTableView.separatorColor = .unselected
        menuTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        menuTableView.sectionHeaderTopPadding = 0
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom)
            make.left.right.equalTo(mainScrollView.frameLayoutGuide)
            make.bottom.equalTo(mainScrollView.frameLayoutGuide)
        }
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerImageCell", for: indexPath) as! BannerImageCell
        cell.bannerImageView.image = bannerImages[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.width
        bannerPageControl.currentPage = Int(pageNumber)
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = bannerCollectionView.frame.width
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksOfselectedCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath) as! DrinkCell
        let drink = drinksOfselectedCategory[indexPath.row]
        
        cell.drinkName.text = drink.fields.name
        cell.drinkDescription.text = drink.fields.description
        cell.drinkPrice.text = "中：\(drink.fields.medium) / 大：\(drink.fields.large)"
        cell.drinkImageView.kf.setImage(with: drink.fields.image.first?.url)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkDetailViewController = DrinkDetailViewController()
        drinkDetailViewController.drink = drinksOfselectedCategory[indexPath.row]
        drinkDetailViewController.userName = userName
        present(drinkDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = menuTableView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeader") as! MenuHeaderView
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let mainOffsetY = mainScrollView.contentOffset.y
        if mainOffsetY >= bannerView.frame.height {
            menuTableView.isScrollEnabled = true
        } else {
            menuTableView.isScrollEnabled = false
        }
        
        let tableOffsetY = menuTableView.contentOffset.y
        if tableOffsetY <= 0 {
            menuTableView.bounces = false
        } else {
            menuTableView.bounces = true
        }
    }
    
}

extension MenuViewController: CategoryButtonDelegate {
    func changeMenuTo(category: String) {
        drinksOfselectedCategory.removeAll()
        for drink in drinks {
            if drink.fields.category.rawValue == category {
                drinksOfselectedCategory.append(drink)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.menuTableView.reloadData()
        }
    }
}
