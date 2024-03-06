//
//  OrderCell.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/1.
//

import UIKit

class OrderCell: UITableViewCell {
    
    let mainStackView = UIStackView()
    let subStackView = UIStackView()
    let drinkImageView = UIImageView()
    let drinkName = UILabel()
    let orderDescription = UILabel()
    let orderName = UILabel()
    let orderPrice = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "orderCell")
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            // 在按住時修改 cell 的樣式
            contentView.backgroundColor = .darkPrimary
        } else {
            // 在放開時恢復 cell 的正常樣式
            contentView.backgroundColor = .primary
        }
    }
    
    func configUI() {
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .primary
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 16
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.left.right.equalToSuperview().inset(16)
        }
        
        mainStackView.addArrangedSubview(drinkImageView)
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.layer.cornerRadius = 8
        drinkImageView.clipsToBounds = true
        drinkImageView.snp.makeConstraints { make in
            make.width.equalTo((contentView.frame.width) / 3.2) // 设置宽度约束
            make.height.equalTo((contentView.frame.width) / 3.2) // 设置高度约束
        }
        
        mainStackView.addArrangedSubview(subStackView)
        subStackView.axis = .vertical
        subStackView.alignment = .leading
        subStackView.distribution = .fillProportionally
        subStackView.spacing = 8
        
        mainStackView.addArrangedSubview(orderPrice)
        orderPrice.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        orderPrice.textColor = .secondary
        
        subStackView.addArrangedSubview(drinkName)
        drinkName.font = UIFont.systemFont(ofSize: 17)
        drinkName.textColor = .white
        
        subStackView.addArrangedSubview(orderDescription)
        orderDescription.font = UIFont.systemFont(ofSize: 14)
        orderDescription.textColor = .gray
        orderDescription.numberOfLines = 2
        
        subStackView.addArrangedSubview(orderName)
        orderName.font = UIFont.systemFont(ofSize: 14)
        orderName.textColor = .gray
    }
    
}
