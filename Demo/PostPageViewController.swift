//
//  PostPageViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/15.
//

import Foundation
import UIKit
import SnapKit

class PostPageViewController: UIViewController {
    
    let postPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let pageControl = UIPageControl()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "photo.on.rectangle.fill"), selectedImage: UIImage(systemName: "photo.on.rectangle.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(postPageCollectionView)
        postPageCollectionView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // 設置每個 cell 的行間距
        postPageCollectionView.collectionViewLayout = layout
        postPageCollectionView.isPagingEnabled = true
        postPageCollectionView.showsHorizontalScrollIndicator = false
        
        postPageCollectionView.delegate = self
        postPageCollectionView.dataSource = self
        
        postPageCollectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(postPageCollectionView.snp.bottom).offset(10)
            make.centerX.equalTo(postPageCollectionView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        pageControl.numberOfPages = accounts.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .tintColor
    }
    
}

extension PostPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        cell.postImageView.image = accounts[indexPath.row].avatar
        return cell
    }
}

extension PostPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = postPageCollectionView.frame.width
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension PostPageViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //x軸偏移量(多加半個螢幕寬，可以達到滑超過一半就換下一頁) / 整個螢幕寬
        let pageNumber = (scrollView.contentOffset.x + scrollView.bounds.width / 2) / scrollView.bounds.width
        pageControl.currentPage = Int(pageNumber)
    }
}
