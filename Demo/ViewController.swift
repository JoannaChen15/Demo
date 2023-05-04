//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 正常是第一頁就要用 nav 但你用 sb 不好改, 所以就先 present 一個 nav 出來
        let red = RedViewController()
        let nav = UINavigationController(rootViewController: red)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false)
    }
}




class RedViewController: UIViewController {
    private let nextBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        nextBtn.setTitle("next", for: .normal)
        nextBtn.backgroundColor = .blue
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
        nextBtn.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        let blue = BlueViewController()
        
        navigationController?.pushViewController(blue, animated: true)
    }
}

class BlueViewController: UIViewController {
    private let popBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "blue"
        
        popBtn.setTitle("pop", for: .normal)
        popBtn.backgroundColor = .red
        view.addSubview(popBtn)
        popBtn.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
        popBtn.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc func tap() {
        navigationController?.popViewController(animated: true)
    }
}


