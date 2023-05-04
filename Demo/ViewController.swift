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
    var newQuestions = [Question]()
    var index = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionRandom()
        
        questionNumber.text = "題目\(index + 1)/10"
        questionNumber.font = .systemFont(ofSize: 18)
        view.addSubview(questionNumber)
        questionNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        questionLabel.text = newQuestions[index].text
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
            make.left.right.equalToSuperview().inset(100)
        }
                
        let options = newQuestions[index].options
        for option in options {
            let button = UIButton()
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.layer.cornerRadius = 6
            button.backgroundColor = .darkGray
            button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
            optionButtons.append(button)
            stackView.addArrangedSubview(button)
            
        }
    }
    
    func questionRandom() {
        var questions = questions
        questions.shuffle()
        for index in 1...10 {
            newQuestions.append(questions[index])
        }
    }
    
    @objc func tabButton(_ sender: UIButton) {
        let question = newQuestions[index]
        
        if index == 9 {
            let alertController = UIAlertController(title: "作答完畢", message: "快來看看你的分數吧！", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "確定", style: .default) { _ in
                let scoreController = ScoreViewController()
                scoreController.score = self.score
                self.present(scoreController, animated: true)
            }
            alertController.addAction(continueAction)
            present(alertController, animated: true)
            
            if let optionChosen = optionButtons.firstIndex(of: sender) {
                if optionChosen == question.answerIndex {
                    score += 10
                }
            }
        } else {
            if let optionChosen = optionButtons.firstIndex(of: sender) {
                if optionChosen == question.answerIndex {
                    let controller = UIAlertController(title: "答對了!", message: "太棒了，請繼續加油！", preferredStyle: .alert)
                    let continueAction = UIAlertAction(title: "繼續", style: .default) { _ in
                        self.next()
                    }
                    controller.addAction(continueAction)
                    present(controller, animated: true)
                    score += 10
                } else {
                    let controller = UIAlertController(title: "答錯了!", message: "正確答案是：\(question.options[question.answerIndex])", preferredStyle: .alert)
                    let continueAction = UIAlertAction(title: "繼續", style: .default) { _ in
                        self.next()
                    }
                    controller.addAction(continueAction)
                    present(controller, animated: true)
                }
            }
        }
        
        
    }
    
    func next() {
        if index < 9 {
            index += 1
            updateUI()
        }
    }
    
    func updateUI() {
        let question = newQuestions[index]
        questionLabel.text = question.text
        
        let options = newQuestions[index].options
        for index in options.indices {
            optionButtons[index].setTitle(options[index], for: .normal)
        }
        
        questionNumber.text = "題目\(index + 1)/10"
        }
}


