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
    private var inputBuffer = ""
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
                bindButtonAction(button)
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

// Actions
private extension ViewController {
    func bindButtonAction(_ button: UIButton) {
        button.addTarget(self, action: #selector(tabButton(_:)), for: .touchUpInside)
    }
    
    @objc func tabButton(_ sender: UIButton) {
        let title = sender.titleLabel?.text ?? ""
        if title == "AC" {
            reset()
        } else if Int(title) != nil {
            inputNumber(title)
        } else if title == "=" {
            calculate()
        } else {
            inputOperator(title)
        }
    }
    
    func reset() {
        displayLabel.text = "0"
    }
    
    func inputNumber(_ title: String) {
        
    }
    
    func calculate() {
        
    }
    
    func inputOperator(_ title: String) {
        
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
