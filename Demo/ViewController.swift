//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let mainStackView = UIStackView()
    let buttonDatas = ButtonDatas()
    let displayLabel = UILabel()
    let operatorLabel = UILabel()
    var currentNumber = ""
    var originalNumber = ""
    var operatorBuffer = ""
    let operators = ["÷", "x", "-", "+"]
    let others = ["C", "±", "%", ".", "⌫", "="]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addButton()
    }
}

extension ViewController {
    func configUI() {
        view.backgroundColor = .background
        configMainStackView()
        configOperatorLabel()
        configDisplayLabel()
    }
    
    func addButton() {
        for titles in buttonDatas.titles {
            let subStackView = UIStackView()
            subStackView.axis = .horizontal
            subStackView.spacing = 10
            mainStackView.addArrangedSubview(subStackView)
            
            for title in titles {
                let button = UIButton()
                button.titleLabel?.font = .systemFont(ofSize: 32)
                button.layer.cornerRadius = 24
                button.snp.makeConstraints { make in
                    make.height.equalTo(button.snp.width)
                }
                subStackView.addArrangedSubview(button)
                button.setTitle("\(title)", for: .normal)
//              設定button顏色
                switch title {
                case "C", "±", "%":
                    button.backgroundColor = .buttonSecondary
                    button.setTitleColor(.text, for: .normal)
                case "÷", "x", "-", "+", "=":
                    button.backgroundColor = .buttonPrimary
                default:
                    button.backgroundColor = .buttonDefault
                    button.setTitleColor(.text, for: .normal)
                }
//              連結功能
                button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
            }
        }
    }
    
    func configMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
    
    func configDisplayLabel() {
        displayLabel.text = "0"
        displayLabel.font = .systemFont(ofSize: 96)
        displayLabel.textColor = .text
        displayLabel.textAlignment = .right
        displayLabel.minimumScaleFactor = 0.6 // 設置最小比例為0.5
        displayLabel.adjustsFontSizeToFitWidth = true // 開啟自動縮小字體大小
        mainStackView.addArrangedSubview(displayLabel)
        displayLabel.snp.makeConstraints { make in
            make.height.equalTo(96)
        }
    }
    
    func configOperatorLabel() {
        operatorLabel.text = ""
        operatorLabel.font = .systemFont(ofSize: 40)
        operatorLabel.textColor = .systemGray
        operatorLabel.textAlignment = .right
        mainStackView.addArrangedSubview(operatorLabel)
    }
    
    @objc func tabButton(_ sender: UIButton) {
        let buttonPressed = sender.currentTitle
            currentNumber = displayLabel.text!
     //      判斷按了什麼按鈕
        if let number = Int(buttonPressed!) { //如果按的是數字
            if currentNumber.hasPrefix("0") { //字首為0時移除
                currentNumber.removeFirst()
            } else if currentNumber.hasPrefix("Error") { //字首為error時移除
                currentNumber.removeFirst(5)
            }
            displayLabel.text = "\(currentNumber)\(number)" //把字串往後加
        }
        if operators.contains(buttonPressed!)  { //如果按的是運算子
            //把被運算的數字存起來
            originalNumber = displayLabel.text!
            //把運算子存起來
            operatorBuffer = buttonPressed!
            //當前結果顯示在上方
            operatorLabel.text = originalNumber + operatorBuffer
            displayLabel.text = ""
        }
        if others.contains(buttonPressed!) { //如果按的是特殊符號
            otherCalculate(buttonPressed!)
        }
    }
    
    func otherCalculate(_ math: String) {
        if math == "C" {
            displayLabel.text = "0"
            reset()
        } else if math == "±" {
            if displayLabel.text != "0" {
                if currentNumber.hasPrefix("-") {
                    displayLabel.text = currentNumber.replacingOccurrences(of: "-", with: "")
                } else {
                    displayLabel.text = "-" + currentNumber
                }
            }
        } else if math == "%" {
            //待處理
//            originalNumber = displayLabel.text!
//            currentNumber = "\(Double(originalNumber)! / 100)"
//            print(currentNumber)
//            displayLabel.text = currentNumber
        } else if math == "." {
            //待處理
        } else if math == "⌫" {
            if currentNumber != "" {
                currentNumber.removeLast()
                displayLabel.text = currentNumber
            }
        } else if math == "=" {
            if let originalInt = Int(originalNumber),
               let currentInt = Int(currentNumber) {
                if originalNumber != "" {
                    currentNumber = displayLabel.text!
                    if operatorBuffer == "+" {
                        displayLabel.text = "\(originalInt + currentInt)"
                    } else if operatorBuffer == "-" {
                        displayLabel.text = "\(originalInt - currentInt)"
                    } else if operatorBuffer == "x" {
                        displayLabel.text = "\(originalInt * currentInt)"
                    } else if operatorBuffer == "÷" {
                        if currentInt == 0 {
                            displayLabel.text = "Error"
                        } else {
                            displayLabel.text = "\(originalInt / currentInt)"
                        }
                    }
                }
                reset()
            }
        }
    }
    
    func reset() {
        currentNumber = ""
        operatorBuffer = ""
        operatorLabel.text = ""
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

