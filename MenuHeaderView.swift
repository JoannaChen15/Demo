//
//  MenuHeaderView.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/23.
//

import UIKit

protocol CategoryButtonDelegate: AnyObject {
    func changeMenuTo(category: String)
}

class MenuHeaderView: UITableViewHeaderFooterView {
    
    let categoryButtonStackView = UIStackView()
    let seasonalButton = UIButton()
    let classicButton = UIButton()
    let mixButton = UIButton()
    let creamButton = UIButton()
    let milkButton = UIButton()
    let underline = UIView()
    let underlineBackground = UIView()
    
    weak var delegate: CategoryButtonDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: "menuHeader")
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUnderlinePositon(button: UIButton) {
        underline.snp.remakeConstraints { make in
            make.bottom.equalTo(categoryButtonStackView.snp.bottom)
            make.width.equalTo(seasonalButton).offset(16)
            make.centerX.equalTo(button)
            make.height.equalTo(2)
        }
        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.contentView.layoutIfNeeded()
        }.startAnimation()
    }
    
    @objc func changeCategory(sender: UIButton) {
        setUnderlinePositon(button: sender)
        for case let button as UIButton in categoryButtonStackView.arrangedSubviews {
            button.isSelected = false
        }
        sender.isSelected = !sender.isSelected
        delegate?.changeMenuTo(category: (sender.titleLabel?.text)!)
    }
    
    func configUI() {
        contentView.backgroundColor = .darkPrimary
        contentView.addSubview(categoryButtonStackView)
        contentView.addSubview(underline)
        contentView.addSubview(underlineBackground)
       
        categoryButtonStackView.axis = .horizontal
        categoryButtonStackView.alignment = .fill
        categoryButtonStackView.distribution = .fillEqually
        categoryButtonStackView.spacing = 0
        categoryButtonStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalToSuperview()
            make.height.equalTo(46)
        }
        
        categoryButtonStackView.addArrangedSubview(seasonalButton)
        categoryButtonStackView.addArrangedSubview(classicButton)
        categoryButtonStackView.addArrangedSubview(mixButton)
        categoryButtonStackView.addArrangedSubview(creamButton)
        categoryButtonStackView.addArrangedSubview(milkButton)
        // 設置 stackView 中所有 Button
        for case let button as UIButton in categoryButtonStackView.arrangedSubviews {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(.unselected, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(changeCategory), for: .touchUpInside)
        }
        seasonalButton.isSelected = true
        seasonalButton.setTitle(Category.seasonal.rawValue, for: .normal)
        classicButton.setTitle(Category.classic.rawValue, for: .normal)
        mixButton.setTitle(Category.mix.rawValue, for: .normal)
        creamButton.setTitle(Category.cream.rawValue, for: .normal)
        milkButton.setTitle(Category.milk.rawValue, for: .normal)
        
        underline.backgroundColor = .secondary
        underline.snp.makeConstraints { make in
            make.bottom.equalTo(categoryButtonStackView.snp.bottom)
            make.width.equalTo(seasonalButton).offset(16)
            make.centerX.equalTo(seasonalButton)
            make.height.equalTo(2)
        }
        
        underlineBackground.backgroundColor = .unselected
        underlineBackground.snp.makeConstraints { make in
            make.bottom.equalTo(categoryButtonStackView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(8)
            make.height.equalTo(0.5)
        }
    }

}
