//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.backgroundColor = .lightGray
        view.addSubview(myView)
        
        myView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let storyPageText = StoryPage.text
        let label = UILabel()
        label.text = storyPageText
        label.textAlignment = .center
        myView.addSubview(label)
        
        
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
    }


}

