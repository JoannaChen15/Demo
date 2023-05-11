//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let notificationTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(notificationTableView)
        notificationTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.center.equalToSuperview()
        }
        
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        
        notificationTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "notificationTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableViewCell", for: indexPath) as! NotificationTableViewCell
//        cell找ViewController當delegate幫忙
        cell.delegate = self
//        畫cell的資料
        cell.set(account: accounts[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let account = accounts[indexPath.row]
        print("選擇的是 \(account.name)")
//        let detailController = AnimalDetailViewController()
//        detailController.fact.text = animal.facts
//        self.present(detailController, animated: true)
//        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension ViewController: NotificationTableViewCellDelegate {    
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

var accounts: [Account] = [
    Account(avatar: UIImage(named: "Upstream"), name: "account0"),
    Account(avatar: UIImage(named: "Upstream-1"), name: "account1"),
    Account(avatar: UIImage(named: "Upstream-2"), name: "account2"),
    Account(avatar: UIImage(named: "Upstream-3"), name: "account3"),
    Account(avatar: UIImage(named: "Upstream-4"), name: "account4"),
    Account(avatar: UIImage(named: "Upstream-5"), name: "account5"),
    Account(avatar: UIImage(named: "Upstream-6"), name: "account6"),
    Account(avatar: UIImage(named: "Upstream-7"), name: "account7"),
    Account(avatar: UIImage(named: "Upstream-8"), name: "account8"),
    Account(avatar: UIImage(named: "Upstream-9"), name: "account9"),
    Account(avatar: UIImage(named: "Upstream-10"), name: "account10"),
    Account(avatar: UIImage(named: "Upstream-11"), name: "account11"),
    Account(avatar: UIImage(named: "Upstream-12"), name: "account12"),
    Account(avatar: UIImage(named: "Upstream-13"), name: "account13"),
    Account(avatar: UIImage(named: "Upstream-14"), name: "account14"),
    Account(avatar: UIImage(named: "Upstream-15"), name: "account15"),
    Account(avatar: UIImage(named: "Upstream-16"), name: "account16"),
    Account(avatar: UIImage(named: "Upstream-17"), name: "account17")
]
