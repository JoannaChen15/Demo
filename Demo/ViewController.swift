//
//  ViewController.swift
//  Demo🏸
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let redView = UIView()
    let blueView = UIView()
    let redScoreButton = UIButton()
    let blueScoreButton = UIButton()
    let redUndoButton = UIButton()
    let blueUndoButton = UIButton()
    var redScore = 0
    var blueScore = 0
    let changeSide = UIButton()
    let restart = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        redScoreButton.addTarget(self, action: #selector(redScorePressed(_:)), for: .touchUpInside)
        blueScoreButton.addTarget(self, action: #selector(blueScorePressed(_:)), for: .touchUpInside)
        redUndoButton.addTarget(self, action: #selector(redUndoPressed(_:)), for: .touchUpInside)
        blueUndoButton.addTarget(self, action: #selector(blueUndoPressed(_:)), for: .touchUpInside)
        restart.addTarget(self, action: #selector(restartPressed(_:)), for: .touchUpInside)
        changeSide.addTarget(self, action: #selector(changeSide(_:)), for: .touchUpInside)
    }
    
    func showRestart() {
        view.addSubview(restart)
        restart.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(160)
        }
        restart.isHidden = false
    }
    
    @objc func redScorePressed(_ sender: UIButton) {
        if redScore < 20 {
            redScore += 1
            redScoreButton.setTitle("\(redScore)", for: .normal)
        } else if redScore >= 20 && blueScore >= 20 {
            redScore += 1
            redScoreButton.setTitle("\(redScore)", for: .normal)
            if redScore == blueScore + 2 {
                redScoreButton.setTitle("Win!", for: .normal)
                showRestart()
            }
        } else {
            redScore += 1
            redScoreButton.setTitle("Win!", for: .normal)
            showRestart()
        }
    }
    
    @objc func blueScorePressed(_ sender: UIButton) {
        if blueScore < 20 {
            blueScore += 1
            blueScoreButton.setTitle("\(blueScore)", for: .normal)
        } else if blueScore >= 20 && redScore >= 20 {
            blueScore += 1
            blueScoreButton.setTitle("\(blueScore)", for: .normal)
            if blueScore == redScore + 2 {
                blueScoreButton.setTitle("Win!", for: .normal)
                showRestart()
            }
        } else {
            blueScore += 1
            blueScoreButton.setTitle("Win!", for: .normal)
            showRestart()
        }
    }
    
    @objc func redUndoPressed(_ sender: UIButton) {
        if redScore > 0 {
            redScore -= 1
            redScoreButton.setTitle("\(redScore)", for: .normal)
        }
        restart.isHidden = true
    }
    
    @objc func blueUndoPressed(_ sender: UIButton) {
        if blueScore > 0 {
            blueScore -= 1
            blueScoreButton.setTitle("\(blueScore)", for: .normal)
        }
        restart.isHidden = true
    }
    
    @objc func restartPressed(_ sender: UIButton) {
        redScore = 0
        redScoreButton.setTitle("\(redScore)", for: .normal)
        blueScore = 0
        blueScoreButton.setTitle("\(blueScore)", for: .normal)
        restart.isHidden = true
    }
    
    @objc func changeSide(_ sender: UIButton) {
        var redScore = redScore
        var blueScore = blueScore
        redScoreButton.setTitle("\(blueScore)", for: .normal)
        blueScoreButton.setTitle("\(redScore)", for: .normal)
        self.redScore = blueScore
        self.blueScore = redScore
    }
}

// UI
private extension ViewController {
    func configUI() {
        configRedView()
        configBlueView()
        configRedScoreButton()
        configBlueScoreButton()
        configRedUndoButton()
        configBlueUndoButton()
        configRestart()
        configChangeSide()
    }
    
    func configRedView() {
        redView.backgroundColor = .red
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func configBlueView() {
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    func configRedScoreButton() {
        redScoreButton.setTitle("\(redScore)", for: .normal)
        redScoreButton.titleLabel?.font = .systemFont(ofSize: 150)
        redView.addSubview(redScoreButton)
        
        redScoreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    func configBlueScoreButton() {
        blueScoreButton.setTitle("\(blueScore)", for: .normal)
        blueScoreButton.titleLabel?.font = .systemFont(ofSize: 150)
        blueView.addSubview(blueScoreButton)
        
        blueScoreButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    func configRedUndoButton() {
        redUndoButton.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
        redUndoButton.setTitle("undo", for: .normal)
        redUndoButton.layer.cornerRadius = 12
        redView.addSubview(redUndoButton)
        
        redUndoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(56)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
    }
    
    func configBlueUndoButton() {
        blueUndoButton.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
        blueUndoButton.setTitle("undo", for: .normal)
        blueUndoButton.layer.cornerRadius = 12
        blueView.addSubview(blueUndoButton)
        
        blueUndoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(56)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
    }
    
    func configRestart() {
        restart.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.8)
        restart.setTitle("RESTART", for: .normal)
        restart.titleLabel?.font = .systemFont(ofSize: 28)
        restart.layer.cornerRadius = 80
        restart.layer.borderWidth = 2
        restart.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    func configChangeSide() {
        changeSide.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.5)
        changeSide.setTitle("Change Side", for: .normal)
        changeSide.layer.cornerRadius = 12
        view.addSubview(changeSide)

        changeSide.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(56)
            make.height.equalTo(35)
            make.width.equalTo(150)
        }
    }
}
