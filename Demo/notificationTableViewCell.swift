//
//  notificationTableViewCell.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/10.
//

import UIKit

class notificationTableViewCell: UITableViewCell {
    private let mainStackView = UIStackView()
    private let avatar = UIImageView()
    private let text = UILabel()
    private let followButton = FollowButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(account: Account) {
        text.text = "\(account.name) 開始追蹤你。"
        avatar.image = account.avatar
        followButton.status = account.followStatus
    }
}

extension notificationTableViewCell {
    func configUI() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        mainStackView.addArrangedSubview(avatar)
        mainStackView.addArrangedSubview(text)
        mainStackView.addArrangedSubview(followButton)
        
        avatar.layer.cornerRadius = 50 / 2
        avatar.layer.masksToBounds = true
        avatar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(avatar.snp.height)
        }
        
        followButton.status = .unfollow
        followButton.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
    }
}

struct Account {
    var avatar: UIImage?
    var name: String
    var followStatus: FollowStatus
    
    init(avatar: UIImage? = nil, name: String, followStatus: FollowStatus = .unfollow) {
        self.avatar = avatar
        self.name = name
        self.followStatus = followStatus
    }
}
