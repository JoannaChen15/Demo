//
//  Test.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/3/8.
//

import UIKit

class Demo: UIScrollView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        print(">>>", view)
        return view
    }
}
