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
    
    let backButton = UIButton()
    
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
        let email = accountTextField.text!
        let password = passwordTextField.text!
        let userName = userNameTextField.text ?? ""
        
        // 檢查暱稱不為空值
        if userName == "" {
            errorMessage.text = "請輸入您的暱稱"
        } else {
            // Firebase註冊
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard let user = result?.user, error == nil else {
                    // 註冊失敗，顯示錯誤訊息
                    self.errorMessage.text = "\(error!.localizedDescription)"
                    return
                }
                
                // 註冊成功，設定使用者名稱
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                changeRequest?.commitChanges(completion: { error in
                    
                    guard error == nil else {
                        // 設定使用者名稱失敗，顯示錯誤訊息
                        self.errorMessage.text = "\(error!.localizedDescription)"
                        return
                    }

                    // 設定使用者成功，註冊完成後關閉視窗
                    self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: Notification.Name("dismissMainLoginView"), object: nil)
                    }
                })
            }
        }
        
    }
    
    @objc func backButtonPressed(sender: UIButton) {
        self.dismiss(animated: true)
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
        
        configBackButton()
    }
    
    func configBackButton() {
        scrollView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.frameLayoutGuide).inset(16)
            make.left.equalTo(scrollView.frameLayoutGuide).inset(16)
            make.size.equalTo(30)
        }
        // 設置圖標大小
        if let image = UIImage(systemName: "xmark") {
            let scaledImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .regular))
            backButton.setImage(scaledImage, for: .normal)
        }
        backButton.tintColor = .gray
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 當用戶按下 return 鍵時，結束編輯狀態
        textField.resignFirstResponder()
        return true
    }
}
