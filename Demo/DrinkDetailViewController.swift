//
//  DrinkDetailViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/23.
//

import UIKit
import Kingfisher

class DrinkDetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let drinkView = UIView()
    let drinkImageView = UIImageView()
    let drinkName = UILabel()
    let drinkDescription = UILabel()
    let backButton = UIButton()
    
    var drink: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(drinkView)
        drinkView.backgroundColor = .white
        drinkView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        drinkView.addSubview(drinkImageView)
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.clipsToBounds = true
        drinkImageView.layer.shadowOpacity = 0
        drinkImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.width * 720 / 960)
        }
        drinkImageView.kf.setImage(with: drink?.fields.image.first?.url)
        
        drinkView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.size.equalTo(46)
        }
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 23
        backButton.layer.shadowColor = UIColor.unselected.cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2) // 陰影偏移量
        backButton.layer.shadowOpacity = 0.2 // 陰影透明度
        backButton.layer.shadowRadius = 6 // 陰影半徑
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.tintColor = .secondary
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        drinkView.addSubview(drinkName)
        drinkName.text = drink?.fields.name
        drinkName.font = UIFont.systemFont(ofSize: 32, weight: .black)
        drinkName.textColor = .darkPrimary
        drinkName.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        drinkView.addSubview(drinkDescription)
        drinkDescription.text = drink?.fields.description
        drinkDescription.font = UIFont.systemFont(ofSize: 14)
        drinkDescription.textColor = .gray
        drinkDescription.snp.makeConstraints { make in
            make.top.equalTo(drinkName.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        drinkView.snp.makeConstraints { make in
            make.bottom.equalTo(drinkDescription.snp.bottom).offset(10)
        }
    }
    
    
    @objc func backButtonPressed(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
    
