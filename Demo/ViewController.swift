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

//
extension ViewController {
    func configUI() {
        view.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 28/255, alpha: 1)
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
                    button.backgroundColor = UIColor(red: 78/255, green: 80/255, blue: 95/255, alpha: 1)
                case "÷", "x", "-", "+", "=":
                    button.backgroundColor = UIColor(red: 75/255, green: 94/255, blue: 252/255, alpha: 1)
                default:
                    button.backgroundColor = UIColor(red: 46/255, green: 47/255, blue: 56/255, alpha: 1)
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
        displayLabel.textColor = .systemBackground
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
//      如果數字不為0就存起來
        if displayLabel.text != "0" {
            currentNumber = displayLabel.text!
        }
     //      判斷按了什麼按鈕
        if let number = Int(buttonPressed!) { //如果按的是數字
            displayLabel.text = "\(currentNumber)\(number)" //就把字串往後加
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
            //待處理
        } else if math == "=" {
            if originalNumber != ""{
                currentNumber = displayLabel.text!
                if operatorBuffer == "+" {
                    displayLabel.text = "\(Int(originalNumber)! + Int(currentNumber)!)"
                } else if operatorBuffer == "-" {
                    displayLabel.text = "\(Int(originalNumber)! - Int(currentNumber)!)"
                } else if operatorBuffer == "x" {
                    displayLabel.text = "\(Int(originalNumber)! * Int(currentNumber)!)"
                } else if operatorBuffer == "÷" {
                    displayLabel.text = "\(Int(originalNumber)! / Int(currentNumber)!)"
                }
            }
            reset()
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
