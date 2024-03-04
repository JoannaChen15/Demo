//
//  DrinkCell.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
//

import UIKit
import SnapKit

class DrinkCell: UITableViewCell {
    
    let mainStackView = UIStackView()
    let subStackView = UIStackView()
    let drinkImageView = UIImageView()
    let drinkName = UILabel()
    let drinkDescription = UILabel()
    let drinkPrice = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "drinkCell")
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            // 在按住時修改 cell 的樣式
            contentView.backgroundColor = .primary
        } else {
            // 在放開時恢復 cell 的正常樣式
            contentView.backgroundColor = .darkPrimary
        }
    }
    
    func configUI() {
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .darkPrimary
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 16
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.left.right.equalToSuperview().inset(16)
        }
        
        mainStackView.addArrangedSubview(subStackView)
        subStackView.axis = .vertical
        subStackView.alignment = .leading
        subStackView.distribution = .fillProportionally
        subStackView.spacing = 8
        
        subStackView.addArrangedSubview(drinkName)
        drinkName.font = UIFont.systemFont(ofSize: 16)
        drinkName.textColor = .white
        
        subStackView.addArrangedSubview(drinkDescription)
        drinkDescription.font = UIFont.systemFont(ofSize: 14)
        drinkDescription.textColor = .secondary
        drinkDescription.numberOfLines = 2
        
        subStackView.addArrangedSubview(drinkPrice)
        drinkPrice.font = UIFont.systemFont(ofSize: 14)
        drinkPrice.textColor = .white
        
        mainStackView.addArrangedSubview(drinkImageView)
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.layer.cornerRadius = 8
        drinkImageView.clipsToBounds = true // 這一行用於確保超出邊界的部分被裁剪掉
        drinkImageView.snp.makeConstraints { make in
            make.size.equalTo((contentView.frame.width) / 3.2)
        }
    }
   
}
