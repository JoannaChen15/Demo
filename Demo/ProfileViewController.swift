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
        layout.scrollDirection = .vertical // 設置滾動方向為垂直方向
        layout.minimumInteritemSpacing = 1 // 設置每個 cell 的水平間距
        layout.minimumLineSpacing = 1 // 設置每個 cell 的垂直間距
        postCollectionView.collectionViewLayout = layout // 設置集合視圖的佈局
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        
        postCollectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCell
        cell.postImageView.image = accounts[indexPath.row].avatar
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = postCollectionView.frame.width / 3 - 1
        return CGSize(width: itemSize, height: itemSize)
    }
}
