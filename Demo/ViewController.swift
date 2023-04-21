//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import AVFAudio
import SnapKit

class ViewController: UIViewController {
    
    let synthesizer = AVSpeechSynthesizer()
    let player = UIButton()
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        //        let hw01 = HW01()
        //        hw01.main()
        //
        //        let hw02 = HW02()
        //        hw02.main()
        
        //講話button
        player.setTitle("🔉", for: .normal)
        player.titleLabel?.font = .systemFont(ofSize: 80)
        
        view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        player.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
        
        //輸入文字
        textField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    @objc func play(_ sender: UIButton) {
        let utterance = AVSpeechUtterance(string: textField.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
