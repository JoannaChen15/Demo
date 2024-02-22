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
        drinkName.text = "草莓檸果"
        drinkDescription.text = "草莓紅茶與鮮切檸檬酸甜滋味搭配Q軟菓玉滿足嚼慾"
        drinkPrice.text = "M : $65  /  L : $75"
        drinkImageView.image = UIImage(named: "logo")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .primary
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 20
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        mainStackView.addArrangedSubview(subStackView)
        mainStackView.addArrangedSubview(drinkImageView)
        
        subStackView.axis = .vertical
        subStackView.alignment = .leading
        subStackView.distribution = .fillProportionally
        subStackView.spacing = 8
        subStackView.addArrangedSubview(drinkName)
        subStackView.addArrangedSubview(drinkDescription)
        subStackView.addArrangedSubview(drinkPrice)
        
        drinkName.font = UIFont.systemFont(ofSize: 18)
        drinkName.textColor = .white
        drinkDescription.font = UIFont.systemFont(ofSize: 15)
        drinkDescription.textColor = .gray
        drinkDescription.numberOfLines = 2
        drinkPrice.font = UIFont.systemFont(ofSize: 15)
        drinkPrice.textColor = .white
        
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.layer.cornerRadius = 16
        drinkImageView.clipsToBounds = true // 這一行用於確保超出邊界的部分被裁剪掉
        drinkImageView.snp.makeConstraints { make in
            make.size.equalTo((contentView.frame.width) / 3)
        }
        
        
        
    }
   
}
