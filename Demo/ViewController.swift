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
        cell.set(cellModel: cellModels[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let account = cellModels[indexPath.row]
        print("選擇的是 \(account)")
//        let detailController = AnimalDetailViewController()
//        detailController.fact.text = animal.facts
//        self.present(detailController, animated: true)
//        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension ViewController: NotificationTableViewCellDelegate {
    func didTapbutton(cellModel: CellModel) {
        guard let index = cellModels.firstIndex(of: cellModel) else { return }
        let followStatus = cellModels[index].followStatus
        let newStatus: FollowStatus
        if followStatus == .unfollow {
            newStatus = .following
        } else {
            newStatus = .unfollow
        }
        cellModels[index].followStatus = newStatus
        notificationTableView.reloadData()
    }
}

var cellModels: [CellModel] = [
    CellModel(avatar: UIImage(named: "Upstream"), name: "account0"),
    CellModel(avatar: UIImage(named: "Upstream-1"), name: "account1"),
    CellModel(avatar: UIImage(named: "Upstream-2"), name: "account2"),
    CellModel(avatar: UIImage(named: "Upstream-3"), name: "account3"),
    CellModel(avatar: UIImage(named: "Upstream-4"), name: "account4"),
    CellModel(avatar: UIImage(named: "Upstream-5"), name: "account5"),
    CellModel(avatar: UIImage(named: "Upstream-6"), name: "account6"),
    CellModel(avatar: UIImage(named: "Upstream-7"), name: "account7"),
    CellModel(avatar: UIImage(named: "Upstream-8"), name: "account8"),
    CellModel(avatar: UIImage(named: "Upstream-9"), name: "account9"),
    CellModel(avatar: UIImage(named: "Upstream-10"), name: "account10"),
    CellModel(avatar: UIImage(named: "Upstream-11"), name: "account11"),
    CellModel(avatar: UIImage(named: "Upstream-12"), name: "account12"),
    CellModel(avatar: UIImage(named: "Upstream-13"), name: "account13"),
    CellModel(avatar: UIImage(named: "Upstream-14"), name: "account14"),
    CellModel(avatar: UIImage(named: "Upstream-15"), name: "account15"),
    CellModel(avatar: UIImage(named: "Upstream-16"), name: "account16"),
    CellModel(avatar: UIImage(named: "Upstream-17"), name: "account17")
]
