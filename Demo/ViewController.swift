//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 正常是第一頁就要用 nav 但你用 sb 不好改, 所以就先 present 一個 nav 出來
        let qnaViewController = QnaViewController()
        let navigationController = UINavigationController(rootViewController: qnaViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false)
        // 設置導航欄返回按鈕的文字
        navigationController.navigationBar.tintColor = .brown
        // 設置導航欄返回按鈕的顏色
        qnaViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
    }
}
