//
//  ScoreViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/4.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var scoreTitle = UILabel()
    var scoreLabel = UILabel()
    var result = UILabel()
    let restart = UIButton()
    
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getResult()
    }
    
    func getResult() {
        guard let score = score else { return }
        scoreLabel.text = "\(score)分"
        if score == 100 {
            result.text = "恭喜！全部答對囉🥳"
        } else if score >= 60, score < 100 {
            result.text = "差一點了，不熟的單字再加強！"
        } else if score < 60 {
            result.text = "錯太多了，回去重背！"
        }
    }
    
    @objc func restartPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func configUI() {
        view.backgroundColor = .lightYellow
        configScoreTitle()
        configScoreLabel()
        configResult()
        configRestart()
    }
    
    func configScoreTitle() {
        scoreTitle.text = "你的分數為:"
        scoreTitle.font = .systemFont(ofSize: 20, weight: .bold)
        scoreTitle.textColor = .brown
        view.addSubview(scoreTitle)
        scoreTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configScoreLabel() {
        scoreLabel.text = ""
        scoreLabel.font = .systemFont(ofSize: 60, weight: .bold)
        scoreLabel.textColor = .darkBrown
        scoreLabel.textAlignment = .center
        scoreLabel.backgroundColor = .white
        scoreLabel.layer.cornerRadius = 25
        scoreLabel.layer.masksToBounds = true
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreTitle.snp.bottom).offset(100)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(scoreLabel.snp.width)
        }
    }
    
    func configResult() {
        result.text = ""
        result.font = .systemFont(ofSize: 20, weight: .bold)
        result.textColor = .brown
        view.addSubview(result)
        result.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(30)
        }
    }
    
    func configRestart() {
        restart.setTitle("重新開始", for: .normal)
        restart.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        restart.layer.cornerRadius = 50/2
        restart.setTitleColor(.white, for: .normal)
        restart.backgroundColor = .lightBrown
        restart.layer.shadowColor = UIColor.black.cgColor // 陰影顏色
        restart.layer.shadowOffset = CGSize(width: 1, height: 2) // 陰影偏移量
        restart.layer.shadowOpacity = 0.3 // 陰影透明度
        restart.layer.shadowRadius = 2 // 陰影半徑
        view.addSubview(restart)
        restart.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        restart.addTarget(self, action: #selector(restartPressed), for: .touchUpInside)
    }
}
