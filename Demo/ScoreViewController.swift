//
//  ScoreViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/4.
//

import UIKit

//protocol ScoreViewControllerDelegate: AnyObject {
//    func scoreViewControllerDidClosed()
//}


class ScoreViewController: UIViewController {
//    weak var delegate: ScoreViewControllerDelegate?
    
    var scoreTitle = UILabel()
    var scoreLabel = UILabel()
    var result = UILabel()
    let restart = UIButton()
    
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        scoreTitle.text = "你的分數為:"
        scoreTitle.font = .systemFont(ofSize: 20)
        view.addSubview(scoreTitle)
        scoreTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        guard let score = score else { return }
        scoreLabel.text = "\(score)分"
        scoreLabel.font = .systemFont(ofSize: 100)
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreTitle.snp.bottom).offset(100)
        }
        
        getResult()
        result.font = .systemFont(ofSize: 26)
        view.addSubview(result)
        result.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(100)
        }
        
        restart.setTitle("重新開始", for: .normal)
        restart.titleLabel?.font = .systemFont(ofSize: 20)
        restart.layer.cornerRadius = 6
        restart.backgroundColor = .tintColor
        view.addSubview(restart)
        restart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(result.snp.bottom).offset(100)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        restart.addTarget(self, action: #selector(restartPressed), for: .touchUpInside)
    }
    
    func getResult() {
        guard let score = score else { return }
        if score == 100 {
            result.text = "台灣景點小達人！"
        } else if score >= 60, score < 100 {
            result.text = "還有景點等著你去探索喔！"
        } else if score < 60 {
            result.text = "太宅了，多出門走走吧！"
        }
    }
    
    @objc func restartPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        delegate?.scoreViewControllerDidClosed()
//    }
}
