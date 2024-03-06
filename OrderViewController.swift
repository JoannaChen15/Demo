//
//  OrderViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let orderTableView = UITableView()
        
    let bottomCheckoutView = UIView()
    let checkoutStackView = UIStackView()
    let checkoutPrice = UILabel()
    let checkoutTitle = UILabel()
    let checkoutNumberOfCups = UILabel()
    
    let imageView = UIImageView(image: UIImage(named: "logo-m"))
    var separatorView = UIView()
    
    var totalPrice = 0
    
    var orders = [CreateOrderDrinkResponseRecord]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart"))
        tabBarItem.badgeColor = .secondary
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrder), name: .orderUpdateNotification, object: nil)
        MenuViewController.shared.fetchOrderList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let orderListResponse):
                self.orders = orderListResponse.records
                self.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設置 navigationItem 圖像
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        // 設置標題顏色為白色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        configUI()
        configBottomCheckoutView()
        
        scrollView.delegate = self
        orderTableView.dataSource = self
        orderTableView.delegate = self
        orderTableView.register(OrderCell.self, forCellReuseIdentifier: "orderCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0, width: view.bounds.width, height: 0.5))
        separatorView.backgroundColor = UIColor.unselected // 設置分隔線顏色
        // 添加分隔線視圖到導航欄
        navigationController?.view.addSubview(separatorView)
        separatorView.isHidden = true
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.orderTableView.reloadData()
            self.checkoutNumberOfCups.text = "共計 \(orders.count)杯"
            calculateTotalPrice()
            self.checkoutPrice.text = "$\(totalPrice)"
            if self.orders.count > 0 {
                self.tabBarItem.badgeValue = "\(self.orders.count)"
            } else {
                self.tabBarItem.badgeValue = nil
            }
        }
    }
    
    func calculateTotalPrice() {
        totalPrice = 0
        for order in orders {
            totalPrice += order.fields.price * order.fields.numberOfCups
        }
    }
    
    @objc func updateOrder() {
        MenuViewController.shared.fetchOrderList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let orderListResponse):
                self.orders = orderListResponse.records
                self.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
        
    func configUI() {
        view.backgroundColor = .primary

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(orderTableView)
        orderTableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(scrollView.frameLayoutGuide)
            make.bottom.equalTo(scrollView.frameLayoutGuide).inset(60)
        }
        orderTableView.backgroundColor = .primary
        orderTableView.separatorColor = .unselected
        orderTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configBottomCheckoutView() {
        scrollView.addSubview(bottomCheckoutView)
        bottomCheckoutView.backgroundColor = .darkPrimary
        bottomCheckoutView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(60)
        }

        bottomCheckoutView.addSubview(checkoutStackView)
        checkoutStackView.axis = .horizontal
        checkoutStackView.spacing = 20
        checkoutStackView.alignment = .center
        checkoutStackView.distribution = .fill
        checkoutStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        checkoutStackView.addArrangedSubview(checkoutTitle)
        checkoutTitle.text = "總金額"
        checkoutTitle.textColor = .secondary
        checkoutTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        checkoutStackView.addArrangedSubview(checkoutNumberOfCups)
        checkoutNumberOfCups.text = "共計 \(orders.count)杯"
        checkoutNumberOfCups.textColor = .gray
        checkoutNumberOfCups.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        checkoutStackView.addArrangedSubview(checkoutPrice)
        checkoutPrice.text = "$\(totalPrice)"
        checkoutPrice.textColor = .secondary
        checkoutPrice.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        bottomCheckoutView.layer.shadowColor = UIColor.black.cgColor
        bottomCheckoutView.layer.shadowOffset = CGSize(width: 0, height: -1) // 陰影偏移量
        bottomCheckoutView.layer.shadowOpacity = 0.2 // 陰影透明度
        bottomCheckoutView.layer.shadowRadius = 4 // 陰影半徑
    }
    
    deinit {
        // 在視圖控制器被銷毀時移除通知觀察者
        NotificationCenter.default.removeObserver(self, name: .orderUpdateNotification, object: nil)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
           
        let order = orders[indexPath.row]
        cell.drinkImageView.kf.setImage(with: order.fields.imageUrl)
        cell.drinkName.text = order.fields.drinkName

        var selectedOptions = [String]()
        selectedOptions.append(order.fields.size)
        selectedOptions.append(order.fields.ice)
        selectedOptions.append(order.fields.sugar)
        selectedOptions += order.fields.addOns ?? []
        cell.orderDescription.text = selectedOptions.joined(separator: "•")
        
        cell.orderName.text = order.fields.orderName
        cell.orderPrice.text = "$\(order.fields.price)"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let order = self.orders[indexPath.row]
            MenuViewController.shared.deleteOrder(orderID: order.id) { result in
                switch result {
                case .success(let message):
                    print(message)
                    DispatchQueue.main.async {
                        self.orders.remove(at: indexPath.row)
                        self.orderTableView.deleteRows(at: [indexPath], with: .left)
                        self.updateUI()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        let drinkDetailViewController = DrinkDetailViewController()
        drinkDetailViewController.editOrder(data: order.fields, id: order.id)
        present(drinkDetailViewController, animated: true)
    }
    
}

extension OrderViewController: UIScrollViewDelegate {
    // 滾動時調整標題
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 10 { // 根據需要調整值
            navigationItem.title = "訂購清單"
            separatorView.isHidden = false
            navigationItem.titleView = nil
        } else {
            navigationItem.title = ""
            separatorView.isHidden = true
            navigationItem.titleView = imageView
        }
    }
}
