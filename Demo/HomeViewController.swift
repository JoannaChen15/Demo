//
//  HomeViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/15.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let notificationTableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self

        notificationTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationTableViewCell")
    }
    
    func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(notificationTableView)
        notificationTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableViewCell", for: indexPath) as! NotificationTableViewCell
//        cell找ViewController當delegate幫忙
        cell.delegate = self
//        畫cell的資料
        cell.set(account: accounts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = accounts[indexPath.row]
        print("選擇的是 \(account.name)")
    }
    
}

extension HomeViewController: NotificationTableViewCellDelegate {
    func didTabFollowButton(account: Account) {
//        按下按鈕後找到按的是第幾筆Account
        guard let index = accounts.firstIndex(of: account) else { return }
//        改變Account的追蹤狀態
        switch accounts[index].followStatus {
        case .unfollow:
            accounts[index].followStatus = .following
        case .following:
            accounts[index].followStatus = .unfollow
        }
//        通知tableView重畫
        notificationTableView.reloadData()
    }
}
