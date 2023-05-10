//
//  AnimalDetailViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/9.
//

import UIKit
import SnapKit

class AnimalDetailViewController: UIViewController {
    
    let fact = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fact.font = .systemFont(ofSize: 30)
        fact.textColor = .tintColor
        view.addSubview(fact)
        fact.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
      
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
