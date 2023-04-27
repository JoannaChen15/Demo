//
//  UIColor+ext.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/27.
//

import UIKit

extension UIColor {
    // 根據 hex init
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
    
    
    // 根據背景模式 給不同顏色
    class var background: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: "#17171C")!
            } else {
                return UIColor(hex: "#F1F2F3")!
            }
        }
    }
    class var buttonDefault: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: "#2E2F38")!
            } else {
                return UIColor(hex: "#FFFFFF")!
            }
        }
    }
    class var buttonSecondary: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: "#4E505F")!
            } else {
                return UIColor(hex: "#D2D3DA")!
            }
        }
    }
    class var buttonPrimary: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: "#4B5EFC")!
            } else {
                return UIColor(hex: "#4B5EFC")!
            }
        }
    }
    class var text: UIColor {
        return UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: "#FFFFFF")!
            } else {
                return UIColor(hex: "#000000")!
            }
        }
    }
}
