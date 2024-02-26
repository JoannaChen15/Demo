//
//  MenuViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import Kingfisher

class MenuViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    
    let bannerView = UIView()
    let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var bannerImages = [UIImage]()
    let bannerPageControl = UIPageControl()
    
    let menuTableView = UITableView()
    var drinks = [Record]()
    var drinksOfselectedCategory = [Record]()
    
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
                    if drink.fields.category == Category.seasonal {
                        self.drinksOfselectedCategory.append(drink)
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
    
    func configUI() {
        view.backgroundColor = .darkPrimary
  
        for index in 0...5 {
            bannerImages.append(UIImage(named: "banner_\(index)")!)
        }
        
        configMainScrollView()
        configBannerView()
        configBannerCollectionView()
        configBannerPageControl()
        configMenuTableView()
    }
    
    func configMainScrollView() {
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configBannerView() {
        mainScrollView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(mainScrollView.contentLayoutGuide)
            make.left.right.equalTo(mainScrollView.frameLayoutGuide)
            make.height.equalTo(280)
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
        }
    }
    
    func configMenuTableView() {
        mainScrollView.addSubview(menuTableView)
        menuTableView.backgroundColor = .darkPrimary
        menuTableView.separatorColor = .unselected
        menuTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = bannerCollectionView.frame.width
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.width
        bannerPageControl.currentPage = Int(pageNumber)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = menuTableView.dequeueReusableHeaderFooterView(withIdentifier: "menuHeader") as! MenuHeaderView
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
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
