//
//  LoginViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/11.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let logoImageView = UIImageView()
    
    let accountLabel = UILabel()
    let accountView = UIView()
    let accountTextField = UITextField()
    
    let passwordLabel = UILabel()
    let passwordView = UIView()
    let passwordTextField = UITextField()
    
    let errorMessage = UILabel()
    let loginButton = UIButton()
    
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
    
    @objc func login() {
        let email = accountTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                self.errorMessage.text = "\(error?.localizedDescription as Any)"
                return
            }
            print("success")
        }
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
            make.top.equalTo(scrollView.contentLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(350)
        }
        
        scrollView.addSubview(accountLabel)
        accountLabel.text = "帳號"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.systemFont(ofSize: 16)
        accountLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.left.equalToSuperview().inset(40)
        }
        
        scrollView.addSubview(accountView)
        accountView.backgroundColor = .white
        accountView.snp.makeConstraints { make in
            make.top.equalTo(accountLabel.snp.bottom).offset(8)
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
        
        scrollView.addSubview(passwordLabel)
        passwordLabel.text = "密碼"
        passwordLabel.textColor = .white
        passwordLabel.font = UIFont.systemFont(ofSize: 16)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(accountView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(40)
        }
        
        scrollView.addSubview(passwordView)
        passwordView.backgroundColor = .white
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
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
        
        scrollView.addSubview(loginButton)
        loginButton.setTitle("登入", for: .normal)
        loginButton.backgroundColor = .secondary
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        loginButton.layer.cornerRadius = 6
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(accountView.snp.height)
        }
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        scrollView.addSubview(errorMessage)
        errorMessage.text = ""
        errorMessage.textColor = .wrongRed
        errorMessage.numberOfLines = 2
        errorMessage.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.contentLayoutGuide)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 當用戶按下 return 鍵時，結束編輯狀態
        textField.resignFirstResponder()
        return true
    }
}

