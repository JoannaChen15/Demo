//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    private let pageControl = UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        pageControl.backgroundColor = .red
        pageControl.numberOfPages = 4
        
        
    }
}



