//
//  ProfileViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/15.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let postCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.circle.fill"), selectedImage: UIImage(systemName: "person.circle.fill"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        view.addSubview(postCollectionView)
        
        postCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 设置滚动方向为垂直方向
//        layout.itemSize = CGSize(width: 100, height: 100) // 设置每个 cell 的大小
        layout.minimumInteritemSpacing = 1 // 设置每个 cell 的水平间距
        layout.minimumLineSpacing = 1 // 设置每个 cell 的垂直间距
        postCollectionView.collectionViewLayout = layout // 设置集合视图的布局
                
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
        postCollectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        cell.postImageView.image = UIImage(named: posts[indexPath.item].postImage)
        return cell
    }
//    UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = postCollectionView.frame.width / 3 - 1
        return CGSize(width: itemSize, height: itemSize)
    }
}

let posts = [
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