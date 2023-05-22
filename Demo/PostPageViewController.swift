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
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1 // 设置每个 cell 的水平间距
        layout.minimumLineSpacing = 1 // 设置每个 cell 的垂直间距
        postPageCollectionView.collectionViewLayout = layout
        
        postPageCollectionView.delegate = self
        postPageCollectionView.dataSource = self
        
        postPageCollectionView.register(PostPageCell.self, forCellWithReuseIdentifier: "postPageCell")
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(postPageCollectionView.snp.bottom).inset(120)
            make.centerX.equalTo(postPageCollectionView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        pageControl.numberOfPages = postPages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .tintColor
    }
}

extension PostPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postPages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postPageCell", for: indexPath) as! PostPageCell
        cell.postImageView.image = UIImage(named: postPages[indexPath.item].postImage)
        return cell
    }
}

extension PostPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = postPageCollectionView.frame.width
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension PostPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        x軸偏移量(多加半個螢幕寬，可以達到滑超過一半就換下一頁) / 整個螢幕寬
        let pageNumber = (scrollView.contentOffset.x + scrollView.bounds.width / 2) / scrollView.bounds.width
        pageControl.currentPage = Int(pageNumber)
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offSet = scrollView.contentOffset.x
//        let width = scrollView.frame.width
//        let horizontalCenter = width / 2
//        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
//    }
}

let postPages = [
    PostModel(postImage: "Teamwork-1"),
    PostModel(postImage: "Teamwork-2"),
    PostModel(postImage: "Teamwork-3"),
    PostModel(postImage: "Teamwork-4"),
    PostModel(postImage: "Teamwork-5"),
    PostModel(postImage: "Teamwork-6"),
    PostModel(postImage: "Teamwork-7"),
    PostModel(postImage: "Teamwork-8"),
    PostModel(postImage: "Upstream-1"),
    PostModel(postImage: "Upstream-2"),
    PostModel(postImage: "Upstream-3"),
    PostModel(postImage: "Upstream-4"),
    PostModel(postImage: "Upstream-5"),
    PostModel(postImage: "Upstream-6"),
    PostModel(postImage: "Upstream-7"),
    PostModel(postImage: "Upstream-8"),
    PostModel(postImage: "Upstream-9"),
    PostModel(postImage: "Upstream-10"),
    PostModel(postImage: "Upstream-11"),
    PostModel(postImage: "Upstream-12"),
    PostModel(postImage: "Upstream-13"),
    PostModel(postImage: "Upstream-14"),
    PostModel(postImage: "Upstream-15"),
    PostModel(postImage: "Upstream-16"),
    PostModel(postImage: "Upstream-17")
]
