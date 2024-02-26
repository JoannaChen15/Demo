//
//  DrinkDetailViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/23.
//

import UIKit
import Kingfisher

class DrinkDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let drinkView = UIView()
    let drinkImageView = UIImageView()
    let drinkName = UILabel()
    let drinkDescription = UILabel()
    let backButton = UIButton()

    let sizeView = UIView()
    let sizeTitle = UILabel()
    
    var selectedButton: RadioButton? // 用於保存當前選中的按鈕
    var selectedOption: String? // 用於儲存當前選中的選項
    
    var drink: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(drinkView)
        drinkView.backgroundColor = .white
        drinkView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        drinkView.addSubview(drinkImageView)
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.clipsToBounds = true
        drinkImageView.layer.shadowOpacity = 0
        drinkImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.width * 720 / 960)
        }
        drinkImageView.kf.setImage(with: drink?.fields.image.first?.url)
        
        drinkView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.size.equalTo(46)
        }
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 23
        backButton.layer.shadowColor = UIColor.unselected.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 陰影偏移量
        backButton.layer.shadowOpacity = 0.2 // 陰影透明度
        backButton.layer.shadowRadius = 6 // 陰影半徑
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.tintColor = .secondary
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        drinkView.addSubview(drinkName)
        drinkName.text = drink?.fields.name
        drinkName.font = UIFont.systemFont(ofSize: 32, weight: .black)
        drinkName.textColor = .darkPrimary
        drinkName.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        drinkView.addSubview(drinkDescription)
        drinkDescription.text = drink?.fields.description
        drinkDescription.font = UIFont.systemFont(ofSize: 14)
        drinkDescription.textColor = .gray
        drinkDescription.snp.makeConstraints { make in
            make.top.equalTo(drinkName.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        drinkView.snp.makeConstraints { make in
            make.bottom.equalTo(drinkDescription.snp.bottom).offset(10)
        }
        
        scrollView.addSubview(sizeView)
        sizeView.backgroundColor = .white
        sizeView.snp.makeConstraints { make in
            make.top.equalTo(drinkView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
          
        // 創建單選按鈕
        let radio1Button = createButton(title: "Option 1", tag: 1)
        let radio2Button = createButton(title: "Option 2", tag: 2)
        let radio3Button = createButton(title: "Option 3", tag: 3)
        sizeView.addSubview(radio1Button)
        sizeView.addSubview(radio2Button)
        sizeView.addSubview(radio3Button)
        
        var previousButton: UIView? // 用於保存前一個按鈕
        for (_, radioButton) in sizeView.subviews.enumerated() {
            // 設置頂部約束
            if let previousButton = previousButton {
                radioButton.snp.makeConstraints { make in
                    make.top.equalTo(previousButton.snp.bottom).offset(10)
                }
            } else {
                radioButton.snp.makeConstraints { make in
                    make.top.equalToSuperview().inset(10)
                }
            }
            // 設置左右約束
            radioButton.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
            }
            // 更新前一個按鈕
            previousButton = radioButton
        }
    }
    
    func createButton(title: String, tag: Int) -> UIButton {
        let radioButton = RadioButton()
        radioButton.titleLable.text = "\(title)"
        radioButton.tag = tag // 使用 tag 屬性標識每個按鈕
        radioButton.delegate = self
        return radioButton
    }
    
    @objc func backButtonPressed(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension DrinkDetailViewController: RadioButtonDelegate {
    
    func optionButtonTapped(_ sender: RadioButton) {
        // 根據按鈕的 tag 設置選中的選項
        switch sender.tag {
        case 1:
            selectedOption = "Option 1"
        case 2:
            selectedOption = "Option 2"
        case 3:
            selectedOption = "Option 3"
        default:
            selectedOption = nil
        }
        
        // 取消先前選中的按鈕
        selectedButton?.status = .unchecked
        
        // 選中當前按鈕
        sender.status = .checked
        selectedButton = sender
        
        // 在這裡可以執行其他操作，比如更新界面或執行相關邏輯
        print("Selected option: \(selectedOption ?? "None")")
    }
    
}
