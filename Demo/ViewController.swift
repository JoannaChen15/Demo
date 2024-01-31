//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit
import Foundation

class ViewController: UIViewController {
    let mainStackView = UIStackView()
    let buttonDatas = ButtonDatas()
    let displayLabel = UILabel()
    let operatorLabel = UILabel()
    var currentDisplayLabel = ""
    var expressionString = ""
    var lastCalculatedNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addButton()
    }
        
    @objc func tabNumberButton(_ sender: UIButton) {
        let number = sender.currentTitle
        currentDisplayLabel = displayLabel.text!
        //數字中沒有小數點且字首為0時
        if !displayLabel.text!.contains(".") && currentDisplayLabel.hasPrefix("0") {
            currentDisplayLabel.removeFirst() //移除字首0
        }
        displayLabel.text = "\(currentDisplayLabel)\(number!)" //把字串往後加
    }
    
    @objc func tabOperatorButton(_ sender: UIButton) {
        var operatorCharacter = sender.currentTitle
        //先把乘除符號換成程式可運算的符號
        if sender.currentTitle == "×" {
            operatorCharacter = "*"
        } else if sender.currentTitle == "÷" {
            operatorCharacter = "/"
        }
        //如果有下一個要加入運算的數字
        if displayLabel.text != "" {
            //把上方運算式存起來
            expressionString = operatorLabel.text!
            //把最後一個被運算的數字存起來
            lastCalculatedNumber = displayLabel.text!
            //當前結果顯示在上方
            operatorLabel.text = expressionString + lastCalculatedNumber + operatorCharacter!
            displayLabel.text = ""
        } else {
            //更換運算子
            operatorLabel.text = expressionString + lastCalculatedNumber + operatorCharacter!
        }
    }
    
    @objc func tabCalculatorControlButton(_ sender: UIButton) {
        let character = sender.currentTitle
        currentDisplayLabel = displayLabel.text!
        switch character {
        case "C":
            displayLabel.text = "0"
            reset()
        case "±":
            guard currentDisplayLabel != "0" else {
                break
            }
            if currentDisplayLabel.hasPrefix("-") {
                displayLabel.text = currentDisplayLabel.replacingOccurrences(of: "-", with: "")
            } else {
                displayLabel.text = "-" + currentDisplayLabel
            }
        case "%":
            guard currentDisplayLabel != "" else {
                break
            }
            let calculateResult = Double(currentDisplayLabel)! / 100
            if calculateResult.truncatingRemainder(dividingBy: 1) == 0 {
                displayLabel.text = String(calculateResult.floor(toInteger: 1))
            } else {
                displayLabel.text = String(calculateResult)
            }
        case ".":
            if displayLabel.text == "" {
                displayLabel.text = "0."
            }
            if !displayLabel.text!.contains(".") {
                displayLabel.text = "\(currentDisplayLabel)\(character!)" //加入小數點
            }
        case "⌫":
            if currentDisplayLabel.count <= 1 {
                displayLabel.text = "0"
            }
            else {
                currentDisplayLabel.removeLast()
                displayLabel.text = currentDisplayLabel
            }
        case "=":
            guard displayLabel.text != "" else {
                break
            }
            var mathExpressionString = "\(operatorLabel.text!)\(currentDisplayLabel)"
            if mathExpressionString.contains("/") && !mathExpressionString.contains(".") {
                mathExpressionString = mathExpressionString.replacingOccurrences(of: "/", with: ".0/")
            }
            let expression = NSExpression(format: mathExpressionString)
            if let calculateResult = expression.expressionValue(with: nil, context: nil) as? Double {
                print(calculateResult)
                if calculateResult.truncatingRemainder(dividingBy: 1) == 0 {
                    displayLabel.text = String(calculateResult.floor(toInteger: 1))
                } else {
                    displayLabel.text = String(calculateResult.rounding(toDecimal: 6))
                }
            }
            reset()
        default:
            //什麼都不做
            break
        }
    }
    
    func reset() {
        currentDisplayLabel = ""
        operatorLabel.text = ""
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
            subStackView.spacing = 16
            mainStackView.addArrangedSubview(subStackView)
            subStackView.distribution = .fillEqually
            
            for title in titles {
                let button = UIButton()
                button.titleLabel?.font = .systemFont(ofSize: 32)
                button.layer.cornerRadius = 24
                button.snp.makeConstraints { make in
                    make.height.equalTo(72)
                }
                subStackView.addArrangedSubview(button)
                button.setTitle("\(title)", for: .normal)
                //設定button顏色
                switch title {
                case "C", "±", "%":
                    button.backgroundColor = .buttonSecondary
                    button.setTitleColor(.textPrimary, for: .normal)
                case "÷", "×", "-", "+", "=":
                    button.backgroundColor = .buttonPrimary
                default:
                    button.backgroundColor = .buttonDefault
                    button.setTitleColor(.textPrimary, for: .normal)
                }
                //連結功能
                switch title {
                case "C", "±", "%", "=", ".", "⌫":
                    button.addTarget(self, action: #selector(tabCalculatorControlButton), for: .touchUpInside)
                case "÷", "×", "-", "+":
                    button.addTarget(self, action: #selector(tabOperatorButton), for: .touchUpInside)
                default:
                    button.addTarget(self, action: #selector(tabNumberButton), for: .touchUpInside)
                }
            }
        }
    }
    
    func configMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 16
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
    }
    
    func configDisplayLabel() {
        displayLabel.text = "0"
        displayLabel.font = .systemFont(ofSize: 96, weight: .light)
        displayLabel.textColor = .textPrimary
        displayLabel.textAlignment = .right
        displayLabel.minimumScaleFactor = 0.6 // 設置最小比例為0.6
        displayLabel.adjustsFontSizeToFitWidth = true // 開啟自動縮小字體大小
        mainStackView.addArrangedSubview(displayLabel)
        displayLabel.snp.makeConstraints { make in
            make.height.equalTo(96)
        }
    }
    
    func configOperatorLabel() {
        operatorLabel.text = ""
        operatorLabel.font = .systemFont(ofSize: 40, weight: .light)
        operatorLabel.textColor = .textSecondary
        operatorLabel.textAlignment = .right
        mainStackView.addArrangedSubview(operatorLabel)
    }
}

extension Double {
    //四捨五入
    func rounding(toDecimal decimal: Int) -> Double {
        let numOfDigits = pow(10.0, Double(decimal))
        return (self * numOfDigits).rounded(.toNearestOrAwayFromZero) / numOfDigits
    }
    //無條件捨去
    func floor(toInteger integer: Int) -> Int {
        let integer = integer - 1
        let numberOfDigits = pow(10.0, Double(integer))
        return Int((self / numberOfDigits).rounded(.towardZero) * numberOfDigits)
    }
}
    
struct ButtonDatas {
    let titles = [
        ["C", "±", "%", "÷"],
        ["7", "8" ,"9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        [".", "0", "⌫", "="]
    ]
}
