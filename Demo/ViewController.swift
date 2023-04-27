//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit
import SwifterSwift


class ViewController: UIViewController {
    let mainStackView = UIStackView()
    let buttonDatas = ButtonDatas()
    let displayLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
       
    }
}

//
extension ViewController {
    func configUI() {
        view.backgroundColor = UIColor(red: 23, green: 23, blue: 28)
        configMainStackView()
        configDisplayLabel()
        addButtonTitle()
    }
    
    func addButtonTitle() {
        for titles in buttonDatas.titles {
            let subStackView = UIStackView()
            subStackView.axis = .horizontal
//            subStackView.distribution = .fillEqually
            subStackView.spacing = 10
//            subStackView.backgroundColor = .blue
            mainStackView.addArrangedSubview(subStackView)
            
            for title in titles {
                let button = UIButton()
                
                switch title {
                case "C", "±", "%":
                    button.backgroundColor = UIColor(red: 78, green: 80, blue: 95)
                case "÷", "x", "-", "+", "=":
                    button.backgroundColor = UIColor(red: 75, green: 94, blue: 252)
                default:
                    button.backgroundColor = UIColor(red: 46, green: 47, blue: 56)
                }
                
                button.titleLabel?.font = .systemFont(ofSize: 32)
                button.layer.cornerRadius = 24
                button.snp.makeConstraints { make in
                    make.height.equalTo(button.snp.width)
                }
                subStackView.addArrangedSubview(button)
                button.setTitle("\(title)", for: .normal)
            }
        }
    }
    
    func configMainStackView() {
        mainStackView.axis = .vertical
//        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
    
    func configDisplayLabel() {
        displayLabel.text = "0"
        displayLabel.font = .systemFont(ofSize: 96)
        displayLabel.textColor = .systemBackground
        displayLabel.textAlignment = .right
        mainStackView.addArrangedSubview(displayLabel)
    }
    
    @objc func tabButton(_ sender: UIButton) {
        
    }
}

struct ButtonDatas {
    let titles = [
        ["C", "±", "%", "÷"],
        ["7", "8" ,"9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        [".", "0", "⌫", "="]
    ]
}
