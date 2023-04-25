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
        let pageControl = UIPageControl()
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        pageControl.backgroundColor = .red
        pageControl.numberOfPages = 4
        
        
        demo(i: 77, completion: { (result: Int) in
            print(result)
            print(pageControl.numberOfPages)
        })
        
        demo(i: 77, completion: comp)
        
        demo(i: 77) {
            print(#line, $0)
        }
    }
    
    func comp(result: Int) {
        print(result)
//        print(pageControl.numberOfPages) 無法辨識
    }
    
    func demo(i: Int, completion: (_ result: Int) -> Void) {
        let result = i + 1
        // 計算了很久以後
        completion(result)
    }
}



