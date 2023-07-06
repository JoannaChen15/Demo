//
//  TableViewCell.swift
//  Demo
//
//  Created by 譚培成 on 2023/6/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    let name = UILabel()
    let drinkDescription = UITextView()
    let price = UILabel()
    let image = UIImageView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(name)
        name.text = "hello world"
        name.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalToSuperview().inset(50)
        }
        
        contentView.addSubview(image)
        image.image = UIImage(named: "")
        image.backgroundColor = .lightGray
        image.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalToSuperview().inset(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
