//
//  UIColor+ext .swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/7.
//

import UIKit
import Foundation

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
    
    class var lightYellow: UIColor {
        return UIColor(hex: "#FEF4DB")!
    }
    
    class var yellow: UIColor {
        return UIColor(hex: "#FFEDBD")!
    }
    
    class var lightBrown: UIColor {
        return UIColor(hex: "#DCAF78")!
    }
    
    class var brown: UIColor {
        return UIColor(hex: "#85643B")!
    }
    
    class var darkBrown: UIColor {
        return UIColor(hex: "#573C1F")!
    }
    
    class var correctGreen: UIColor {
        return UIColor(hex: "#7BCF7A")!
    }
    
    class var wrongRed: UIColor {
        return UIColor(hex: "#E3714D")!
    }
}
