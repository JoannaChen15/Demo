//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    private let stackView = UIStackView()
    private let redButton = UIButton()
    private let blueButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(redButton)
        stackView.addArrangedSubview(blueButton)
        redButton.backgroundColor = .red
        blueButton.backgroundColor = .blue
        redButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        let vc: UIViewController
        if sender === redButton {
            vc = RedViewController()
        } else {
            vc = BlueViewController()
        }
        present(vc, animated: true)
    }
}

// MARK: -
class RedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}


// MARK: -
class BlueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

