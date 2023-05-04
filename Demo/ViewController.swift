//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit
import AVKit


class ViewController: UIViewController {
    
    var questionNumber = UILabel()
    var questionLabel = UILabel()
    var optionButtons = [UIButton]()
    let stackView = UIStackView()
    var index = 0
    var score = 0
//    let playButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionNumber.text = "題目\(index + 1)/10"
        questionNumber.font = .systemFont(ofSize: 18)
        view.addSubview(questionNumber)
        questionNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        questionLabel.text = questions[0].text
        questionLabel.font = .systemFont(ofSize: 18)
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(questionNumber).inset(100)
        }
        
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(50)
        }
                
        let options = questions[index].options
        for option in options {
            let button = UIButton()
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.backgroundColor = .orange
            button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
            optionButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
//        playButton.setTitle("PLAY", for: .normal)
//        playButton.backgroundColor = .blue
//        view.addSubview(playButton)
//        playButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalTo(100)
//        }
//        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        
    }
    
    @objc func tabButton(_ sender: UIButton) {
//        計分
        let question = questions[index]
        if let optionChosen = optionButtons.firstIndex(of: sender) {
            if optionChosen == question.answerIndex {
                score += 10
            }
        }
//        檢查是否為最後一題
        let controller = ScoreViewController()
        controller.score = score
        present(controller, animated: true)
        
        
//        下一題
        index += 1
        updateUI()
    }
    
    func updateUI() {
        let question = questions[index]
        questionLabel.text = question.text
        
        let options = questions[index].options
        for index in options.indices {
            optionButtons[index].setTitle(options[index], for: .normal)
        }
        
        questionNumber.text = "題目\(index + 1)/10"
    }
          
    
   
    
//    @objc func play(_ sender: Any) {
//        if let url = URL(string: "https://video-ssl.itunes.apple.com/apple-assets-us-std-000001/Video128/v4/ac/7c/62/ac7c6274-60ea-5b7c-4c99-f08d78bfe574/mzvf_484000410198456586.640x352.h264lc.U.p.m4v") {
//            let player = AVPlayer(url: url)
//
//        }
//    }
}


