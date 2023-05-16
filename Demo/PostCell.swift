//
//  PostCell.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/15.
//

import Foundation
import UIKit
import SnapKit

class PostCell: UICollectionViewCell {
    let postImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        postImageView.contentMode = .scaleAspectFill
//        postImageView.clipsToBounds = true
        contentView.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}
