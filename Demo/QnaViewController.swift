//
//  QnaViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/7.
//

import UIKit
import SnapKit

class QnaViewController: UIViewController {
    
    let qnaTitle = UILabel()
    let qnaDescription = UILabel()
    let questionView = UIView()
    let questionNumber = UILabel()
    let questionLabel = UILabel()
    let stackView = UIStackView()
    var optionButtons = [UIButton]()
    var newQuestions = [Question]()
    var index: Int = 0
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        questionRandom()
        configUI()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        index = 0
        score = 0
        questionRandom()
        updateUI()
    }
    
    func questionRandom() {
        newQuestions.removeAll()
        var questions = questions
        questions.shuffle()
        for index in 1...10 {
            newQuestions.append(questions[index])
        }
    }
    
    func updateUI() {
        let question = newQuestions[index]
        //題目文字
        questionLabel.text = question.text
        //選項按鈕文字、顏色
        let options = question.options
        for index in options.indices {
            optionButtons[index].setTitle(options[index], for: .normal)
            optionButtons[index].backgroundColor = .lightBrown
        }
        //目前在第幾題
        questionNumber.text = "\(index + 1)/10"
    }
    
    @objc func tabButton(_ sender: UIButton) {
        let question = newQuestions[index]
        //查找發送動作的按鈕在Array中的index
        guard let optionChosen = optionButtons.firstIndex(of: sender) else { return }
        //答對
        if optionChosen == question.answerIndex {
            sender.backgroundColor = .correctGreen
            score += 10
            if isLastQuestion(index: index) {
                presentResult()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self else { return }
                self.next()
            }
        } else {
            //答錯
            sender.backgroundColor = .wrongRed
            let controller = UIAlertController(title: "答錯了!", message: "正確答案是：\(question.options[question.answerIndex])", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "繼續", style: .default) { [weak self] _ in
                guard let self else { return }
                if self.isLastQuestion(index: index) {
                    self.presentResult()
                }
                self.next()
            }
            controller.addAction(continueAction)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                guard let self else { return }
                present(controller, animated: true)
                optionButtons[question.answerIndex].backgroundColor = .correctGreen
            }
        }
    }
    
    func next() {
        if index < 9 {
            index += 1
            updateUI()
        }
    }
    
    func isLastQuestion(index: Int) -> Bool {
        return index == 9
    }
    
    func presentResult() {
        let alertController = UIAlertController(title: "作答完畢", message: "快來看看你的分數吧！", preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "確定", style: .default) { [weak self] _ in
            guard let self else { return }
            let scoreViewController = ScoreViewController()
            //將分數從問題頁傳到分數頁
            scoreViewController.score = self.score
            self.navigationController?.pushViewController(scoreViewController, animated: true)
        }
        alertController.addAction(continueAction)
        present(alertController, animated: true)
    }
    
    func configUI() {
        view.backgroundColor = .lightYellow
        configQnaTitle()
        configQnaDescription()
        configQuestionView()
        configQuestionNumber()
        configQuestionLabel()
        configStackView()
        addOptionButtons()
    }
    
    func configQnaTitle() {
        qnaTitle.text = "英翻中選擇題"
        qnaTitle.font = .systemFont(ofSize: 20, weight: .bold)
        qnaTitle.textColor = .brown
        view.addSubview(qnaTitle)
        qnaTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configQnaDescription() {
        qnaDescription.text = "請選出此單字的中文解釋"
        qnaDescription.font = .systemFont(ofSize: 14, weight: .bold)
        qnaDescription.textColor = .brown
        view.addSubview(qnaDescription)
        qnaDescription.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(qnaTitle.snp.bottom).offset(30)
        }
    }
    
    func configQuestionView() {
        questionView.backgroundColor = .yellow
        questionView.layer.cornerRadius = 25
        view.addSubview(questionView)
        questionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(qnaDescription.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    func configQuestionNumber() {
        questionNumber.text = "\(index + 1)/10"
        questionNumber.font = .systemFont(ofSize: 18, weight: .medium)
        questionNumber.textColor = .darkBrown
        questionView.addSubview(questionNumber)
        questionNumber.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }
    
    func configQuestionLabel() {
        questionLabel.text = newQuestions[index].text
        questionLabel.font = .systemFont(ofSize: 36, weight: .bold)
        questionLabel.textColor = .darkBrown
        questionView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(questionView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    func addOptionButtons() {
        for _ in 0 ..< 4 {
            let button = UIButton()
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
            button.layer.cornerRadius = 50/2
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .lightBrown
            button.layer.shadowColor = UIColor.black.cgColor // 陰影顏色
            button.layer.shadowOffset = CGSize(width: 1, height: 2) // 陰影偏移量
            button.layer.shadowOpacity = 0.3 // 陰影透明度
            button.layer.shadowRadius = 2 // 陰影半徑
            button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
            optionButtons.append(button)
            stackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}
