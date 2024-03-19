//
//  Checkbox.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/27.
//

import UIKit

protocol CheckboxDelegate: AnyObject {
    func checkboxTapped(_ sender: Checkbox)
}

class Checkbox: UIButton {
    
    let titleLable = UILabel()
    let checkImageView = UIImageView()
    var shortName: String = ""
    var type: TypeOfOption?
    weak var delegate: CheckboxDelegate?
    var status: CheckboxStatus = .unchecked {
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
        
        addTarget(self, action: #selector(didChecked), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateUI() {
        self.checkImageView.image = status.image
    }
    
    @objc func didChecked(sender: UIButton) {
        switch self.status {
        case .unchecked:
            self.status = .checked
        case .checked:
            self.status = .unchecked
        }
        self.delegate?.checkboxTapped(sender as! Checkbox)
    }
}

enum CheckboxStatus {
    case checked
    case unchecked
    
    var image: UIImage {
        switch self {
        case .unchecked:
            return UIImage(systemName: "square")!
        case .checked:
            return UIImage(systemName: "checkmark.square.fill")!
        }
    }
}
