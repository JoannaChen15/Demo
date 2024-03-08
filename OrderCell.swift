//
//  OrderCell.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/1.
//

import UIKit

protocol OrderCellDelegate: AnyObject {
    func updateQuantityAndPrice(sender: UIButton, numberOfCups: Int, orderPrice: Int)
}

class OrderCell: UITableViewCell {
    
    let mainStackView = UIStackView()
    let subStackView = UIStackView()
    let drinkImageView = UIImageView()
    let drinkName = UILabel()
    let orderDescription = UILabel()
    let orderName = UILabel()
    let orderPriceLabel = UILabel()
    
    let numberOfCupsView = UIView()
    let minusButton = UIButton()
    let plusButton = UIButton()
    let numberOfCupsLabel = UILabel()
    
    var numberOfCups = 1
    var orderPrice = 0
    
    var order: CreateOrderDrinkResponseRecord?
    
    weak var delegate: OrderCellDelegate?
        
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
    
    func set(order: CreateOrderDrinkResponseRecord) {
        self.order = order
        self.drinkImageView.kf.setImage(with: order.fields.imageUrl)
        self.drinkName.text = order.fields.drinkName

        var selectedOptions = [String]()
        selectedOptions.append(order.fields.size)
        selectedOptions.append(order.fields.ice)
        selectedOptions.append(order.fields.sugar)
        selectedOptions += order.fields.addOns ?? []
        self.orderDescription.text = selectedOptions.joined(separator: "•")
        
        self.orderName.text = order.fields.orderName
        numberOfCups = order.fields.numberOfCups
        self.numberOfCupsLabel.text = "\(numberOfCups)"
        self.orderPriceLabel.text = "$\(order.fields.price)"
        orderPrice = order.fields.price / numberOfCups
    }
    
    @objc func minusCup() {
        if numberOfCups > 1 {
            numberOfCups -= 1
        }
        let orderPrice = orderPrice * numberOfCups
        delegate?.updateQuantityAndPrice(sender: self.minusButton, numberOfCups: numberOfCups, orderPrice: orderPrice)
    }
    
    @objc func plusCup() {
        numberOfCups += 1
        let orderPrice = orderPrice * numberOfCups
        delegate?.updateQuantityAndPrice(sender: self.plusButton, numberOfCups: numberOfCups, orderPrice: orderPrice)
    }
    
    func configUI() {
        contentView.addSubview(mainStackView)
        contentView.backgroundColor = .primary
        
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 16
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
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
        
        mainStackView.addArrangedSubview(orderPriceLabel)
        orderPriceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        orderPriceLabel.textColor = .secondary
        
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
        
        subStackView.addArrangedSubview(numberOfCupsView)
        
        numberOfCupsView.addSubview(minusButton)
        minusButton.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.size.equalTo(36)
        }
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.backgroundColor = .darkPrimary
        minusButton.tintColor = .white
        minusButton.layer.cornerRadius = 18
        minusButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // 指定要設置圓角的角落
        minusButton.addTarget(self, action: #selector(minusCup), for: .touchUpInside)
        
        numberOfCupsView.addSubview(numberOfCupsLabel)
        numberOfCupsLabel.backgroundColor = .darkPrimary
        numberOfCupsLabel.textAlignment = .center
        numberOfCupsLabel.textColor = .white
        numberOfCupsLabel.font = UIFont.systemFont(ofSize: 14)
        numberOfCupsLabel.snp.makeConstraints { make in
            make.left.equalTo(minusButton.snp.right)
            make.top.bottom.equalToSuperview()
            make.size.equalTo(36)
        }
        
        numberOfCupsView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.left.equalTo(numberOfCupsLabel.snp.right)
            make.top.bottom.right.equalToSuperview()
            make.size.equalTo(36)
        }
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.backgroundColor = .darkPrimary
        plusButton.tintColor = .white
        plusButton.layer.cornerRadius = 18
        plusButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner] // 指定要設置圓角的角落
        plusButton.addTarget(self, action: #selector(plusCup), for: .touchUpInside)
    }
    
}
