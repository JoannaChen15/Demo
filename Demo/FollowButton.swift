//
//  FollowButton.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/10.
//

import UIKit

class FollowButton: UIButton {
    var status: FollowStatus = .unfollow {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        updateUI()
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        self.backgroundColor = status.backgroundColor
        self.setTitle(status.title, for: .normal)
        self.titleLabel?.textColor = status.textColor
    }
}

enum FollowStatus {
    case unfollow
    case following
    
    var title: String {
        switch self {
        case .unfollow:
            return "追蹤"
        case .following:
            return "追蹤中"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .unfollow:
            return .tintColor
        case .following:
            return .lightGray
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .unfollow:
            return .white
        case .following:
            return .black
        }
    }
}
