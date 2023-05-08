//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIColorPickerViewControllerDelegate {
    let button = UIButton()
    let color = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.backgroundColor = .blue
        button.setTitle("pick Photo", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
            make.size.equalTo(200)
        }
        
        button.addTarget(self, action: #selector(pick), for: .touchUpInside)
        
        color.backgroundColor = .gray
        color.setTitle("pick color", for: .normal)
        view.addSubview(color)
        color.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(100)
            make.size.equalTo(200)
        }
        
        color.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
    }
    
    @objc func pick() {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true)
    }
    
    @objc func pickColor() {
        let controller = UIColorPickerViewController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickImage = info[.originalImage] as? UIImage
        button.setImage(pickImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let pickColor = color
        self.color.backgroundColor = pickColor
        dismiss(animated: true)
    }
}
