//
//  RegisterViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/12.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let logoImageView = UIImageView()
    
    let accountLabel = UILabel()
    let accountView = UIView()
    let accountTextField = UITextField()
    
    let userNameLabel = UILabel()
    let userNameView = UIView()
    let userNameTextField = UITextField()
    
    let passwordLabel = UILabel()
    let passwordView = UIView()
    let passwordTextField = UITextField()
    
    let errorMessage = UILabel()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // 添加點擊手勢
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // 訂閱鍵盤彈出和隱藏的通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // 在視圖控制器銷毀時取消訂閱通知
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true) // 收起所有正在編輯的元素的鍵盤
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // 獲取鍵盤的高度
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // 設置 scrollView 的內容偏移量，使文本字段在鍵盤上方可見
        scrollView.contentInset.bottom = keyboardSize.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // 隱藏鍵盤時重置 scrollView 的內容偏移量
        scrollView.contentInset = .zero
    }
    
    @objc func register() {
    }
        
    func configUI() {
        view.backgroundColor = .darkPrimary
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "login")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.5)
        }
        
        scrollView.addSubview(accountLabel)
        accountLabel.text = "註冊信箱"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.systemFont(ofSize: 16)
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(40)
        }
        
        scrollView.addSubview(accountView)
        accountView.backgroundColor = .white
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        accountView.addSubview(accountTextField)
        accountTextField.placeholder = "Email"
        accountTextField.textColor = .darkPrimary
        accountTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        accountTextField.delegate = self
        
        scrollView.addSubview(userNameLabel)
        userNameLabel.text = "暱稱"
        userNameLabel.textColor = .white
        userNameLabel.font = UIFont.systemFont(ofSize: 16)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(40)
        }
        
        scrollView.addSubview(userNameView)
        userNameView.backgroundColor = .white
        userNameView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        userNameView.addSubview(userNameTextField)
        userNameTextField.placeholder = "Enter your name"
        userNameTextField.textColor = .darkPrimary
        userNameTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        userNameTextField.delegate = self
        
        scrollView.addSubview(passwordLabel)
        passwordLabel.text = "設定密碼"
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont.systemFont(ofSize: 16)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(40)
        }
        
        scrollView.addSubview(passwordView)
        passwordView.backgroundColor = .white
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        passwordView.addSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.textColor = .darkPrimary
        passwordTextField.isSecureTextEntry = true
        passwordTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
        }
        passwordTextField.delegate = self
        
        scrollView.addSubview(registerButton)
        registerButton.setTitle("註冊", for: .normal)
        registerButton.backgroundColor = .secondary
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        registerButton.layer.cornerRadius = 6
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(accountView.snp.height)
        }
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        scrollView.addSubview(errorMessage)
        errorMessage.text = ""
        errorMessage.textColor = .wrongRed
        errorMessage.numberOfLines = 2
        errorMessage.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).offset(-6)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.contentLayoutGuide).inset(60)
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 當用戶按下 return 鍵時，結束編輯狀態
        textField.resignFirstResponder()
        return true
    }
}
