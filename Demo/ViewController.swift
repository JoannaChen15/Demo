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
        
        let label = UILabel()
        label.text = "Hello, World"
        label.textAlignment = .center
        myView.addSubview(label)
                    
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        let lemonGreen = UIView(frame: CGRect(x: 0, y: 450, width: 200, height: 200))
        lemonGreen.backgroundColor = UIColor(red: 20/255, green: 100/255, blue: 20/255, alpha: 1)
        view.addSubview(lemonGreen)
        
        let lemonImageView = UIImageView(image: UIImage(named: "lemon"))
        lemonImageView.frame = CGRect(x: 0, y: 0, width: 180, height: 150)
        lemonImageView.layer.cornerRadius = 50
        lemonGreen.addSubview(lemonImageView)
    }
}

class CapsuleBorderButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 2
        layer.cornerRadius = bounds.midY
        layer.borderColor = titleColor(for: .normal)?.cgColor
    }
}

