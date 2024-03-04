//
//  UIColor+ext .swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/22.
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
}

extension UIColor {
    
    class var primary: UIColor {
        return UIColor(hex: "#003e52")!
    }
    
    class var secondary: UIColor {
        return UIColor(hex: "#bc955c")!
    }
    
    class var lightSecondary: UIColor {
        return UIColor(hex: "#FDC982")!
    }

    class var darkPrimary: UIColor {
        return UIColor(hex: "#002F3F")!
    }
    
    class var unselected: UIColor {
        return UIColor(hex: "#6a7579")!
    }
    
    class var gray: UIColor {
        return UIColor(hex: "#a7a8a9")!
    }
    
    class var wrongRed: UIColor {
        return UIColor(hex: "#B13647")!
    }
    
    class var wrongRedBackground: UIColor {
        return UIColor(hex: "#FBF1EF")!
    }
    
    class var correctGreen: UIColor {
        return UIColor(hex: "#24764D")!
    }
    
    class var correctGreenBackground: UIColor {
        return UIColor(hex: "#EAF6ED")!
    }
    
}
