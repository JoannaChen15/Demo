//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let mainStack = UIStackView()
    private let displayLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

// UI
extension ViewController {
    func configUI() {
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.distribution = .fillEqually
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addDisplayLabel()
        addButtons()
    }
    func addButtons() {
        let buttonDatas = ButtonDatas()
        for titles in buttonDatas.titles {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 10
            for title in titles {
                let button = UIButton()
                button.setTitle(title, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
                stack.addArrangedSubview(button)
            }
            mainStack.addArrangedSubview(stack)
        }
    }
    func addDisplayLabel() {
        displayLabel.backgroundColor = .white
        displayLabel.text = "0"
        displayLabel.textColor = .black
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.systemFont(ofSize: 60)
        mainStack.addArrangedSubview(displayLabel)
    }
}


struct ButtonDatas {
    let titles = [
        ["7", "8" ,"9", "÷"],
        ["4", "5", "6", "x"],
        ["1", "2", "3", "-"],
        ["AC", "0", "=", "+"]
    ]
}
