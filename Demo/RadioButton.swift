//
//  RadioButton.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/25.
//

import UIKit

protocol RadioButtonDelegate {
    func optionButtonTapped(_ sender: RadioButton)
}

class RadioButton: UIButton {
    
    let titleLable = UILabel()
    let checkImageView = UIImageView()
    var delegate: RadioButtonDelegate?
    var status: RadioButtonStatus = .unchecked {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLable.text = "test"
        titleLable.textColor = .darkPrimary        
        titleLable.font = UIFont.systemFont(ofSize: 18)
        
        addSubview(checkImageView)
        checkImageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(titleLable.snp.height)
        }
        checkImageView.tintColor = .darkPrimary
        checkImageView.image = status.image
        
        addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateUI() {
        self.checkImageView.image = status.image
    }
    
    @objc func onClick(sender: UIButton) {
        self.status = .checked
        self.delegate?.optionButtonTapped(sender as! RadioButton)
        print("test")
    }
}

enum RadioButtonStatus {
    case checked
    case unchecked
    
    var image: UIImage {
        switch self {
        case .unchecked:
            return UIImage(systemName: "circle")!
        case .checked:
            return UIImage(systemName: "circle.fill")!
        }
    }
}
