//
//  BannerCell.swift
//  Demo
//
//  Created by Tan Elijah on 2024/3/4.
//

import UIKit

class BannerCell: UITableViewCell {
    private let bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var bannerImages = [UIImage]()
    private let bannerPageControl = UIPageControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerImageCell", for: indexPath) as! BannerImageCell
        cell.bannerImageView.image = bannerImages[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.bounds.width
        bannerPageControl.currentPage = Int(pageNumber)
    }
}

extension BannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = bannerCollectionView.frame.width
        return CGSize(width: itemSize, height: itemSize)
    }
}

private extension BannerCell {
    func configUI() {
        for index in 0...5 {
            bannerImages.append(UIImage(named: "banner_\(index)")!)
        }
        contentView.backgroundColor = .darkPrimary
        configCollectionView()
        configPageControl()
    }
    
    func configCollectionView() {
        contentView.addSubview(bannerCollectionView)
        bannerCollectionView.backgroundColor = .clear
        bannerCollectionView.isPagingEnabled = true // 啓用分頁效果
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(230)
        }
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: "bannerImageCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        bannerCollectionView.collectionViewLayout = layout
    }
    
    func configPageControl() {
        contentView.addSubview(bannerPageControl)
        bannerPageControl.numberOfPages = bannerImages.count
        bannerPageControl.currentPage = 0
        bannerPageControl.pageIndicatorTintColor = .unselected
        bannerPageControl.currentPageIndicatorTintColor = .secondary
        bannerPageControl.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(25)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
