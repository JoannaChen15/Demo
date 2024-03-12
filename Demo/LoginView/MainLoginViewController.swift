//
//  MainLoginViewController.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/8.
//

import UIKit
import SnapKit

class MainLoginViewController: UIViewController {
    
    let logoImageView = UIImageView()
    
    let guestLoginLabel = UILabel()
    let guestLoginView = UIView()
    let guestLoginTextField = UITextField()
    let guestLoginButton = UIButton()
    
    let loginButton = UIButton()
    let registerButton = UIButton()
    
    let errorMessage = UILabel()
        
    var onLoginSuccess: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // 添加點擊手勢
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDismissed), name: Notification.Name("dismissMainLoginView"), object: nil)
    }
    
    @objc func handleDismissed() {
        self.dismiss(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true) // 收起所有正在編輯的元素的鍵盤
    }
    
    @objc func guestLogin() {
        let userName = guestLoginTextField.text ?? ""
        if userName == "" {
            errorMessage.text = "請輸入訪客名稱"
        } else {
            onLoginSuccess?(userName)
            print(userName)
            self.dismiss(animated: true)
        }
    }
    
    @objc func loginButtonTapped() {
        errorMessage.text = ""
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true)
    }
    
    @objc func registerButtonTapped() {
        errorMessage.text = ""
        let registerViewController = RegisterViewController()
        present(registerViewController, animated: true)
    }
    
    func configUI() {
        view.backgroundColor = .darkPrimary
        
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "login")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.5)
        }
        
        view.addSubview(guestLoginLabel)
        guestLoginLabel.text = "訪客登入"
        guestLoginLabel.textColor = .white
        guestLoginLabel.font = UIFont.systemFont(ofSize: 16)
        guestLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(40)
        }
        
        view.addSubview(guestLoginView)
        guestLoginView.backgroundColor = .white
        guestLoginView.snp.makeConstraints { make in
            make.top.equalTo(guestLoginLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
        
        guestLoginView.addSubview(guestLoginTextField)
        guestLoginTextField.placeholder = "Enter your name"
        guestLoginTextField.textColor = .darkPrimary
        guestLoginTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        guestLoginTextField.delegate = self
        
        guestLoginView.addSubview(guestLoginButton)
        guestLoginButton.backgroundColor = .secondary
        guestLoginButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        guestLoginButton.tintColor = .white
        guestLoginButton.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(guestLoginTextField.snp.right)
            make.size.equalTo(guestLoginView.snp.height)
        }
        guestLoginButton.addTarget(self, action: #selector(guestLogin), for: .touchUpInside)
        
        view.addSubview(errorMessage)
        errorMessage.text = ""
        errorMessage.textColor = .wrongRed
        errorMessage.numberOfLines = 2
        errorMessage.font = UIFont.systemFont(ofSize: 16)
        errorMessage.snp.makeConstraints { make in
            make.top.equalTo(guestLoginView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
        }
        
        view.addSubview(loginButton)
        loginButton.setTitle("帳密登入", for: .normal)
        loginButton.backgroundColor = .white
        loginButton.setTitleColor(.primary, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        loginButton.layer.cornerRadius = 6
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(guestLoginView.snp.height)
        }
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        view.addSubview(registerButton)
        registerButton.setTitle("註冊", for: .normal)
        registerButton.backgroundColor = .secondary
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        registerButton.layer.cornerRadius = 6
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(guestLoginView.snp.height)
        }
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).offset(-20)
        }
    }
    
}

extension MainLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 當用戶按下 return 鍵時，結束編輯狀態
        textField.resignFirstResponder()
        return true
    }
}
