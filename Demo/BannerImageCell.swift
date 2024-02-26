//
//  BannerImageCell.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/24.
//

import UIKit

class BannerImageCell: UICollectionViewCell {
    
    let bannerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        bannerImageView.contentMode = .scaleAspectFit
        bannerImageView.clipsToBounds = true
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
