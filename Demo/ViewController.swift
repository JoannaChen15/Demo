//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
// 人類可以吃
protocol Human {
    func eat()
}

class Baby: Human {
    // 所以 baby 一定要有吃的功能
    func eat() {
        
    }
    
    // baby 有新功能 不是每個人都有的
    func cry() {
        
    }
}

class SuperBaby: Baby {
    // 他會飛
    func fly() {
        
    }
}

// 來跑第一段測試
func test1() {
    let tim: Human = SuperBaby()
    tim.eat() // 毫無懸念
    // tim.cry() // 錯誤, tim 表面來說他只是個人類, 我們不能叫他哭
    
    // 我們要向世人宣告, 他其實只是個孩子, 他哭是正常的
    (tim as! Baby).cry()
    
    // 然後我們要測試他是不是超級寶寶, 不然直接叫他飛可能會出事
    if tim is SuperBaby {
        (tim as! SuperBaby).fly()
    }
    
    // 但其實現在很少用 as! 都改用 as?
    (tim as? SuperBaby)?.fly() // 你飛飛看, 能飛就飛吧～ 不能飛算了
}


// 然後要幫超級寶寶新增能力
protocol Killer {
    func kill()
}

extension SuperBaby: Killer {
    // 遵從 protocol 就一定要實作
    func kill() {
        
    }
}

// 現在再來第二段測試

func test2() {
    let tim: Killer = SuperBaby() // 他是個殺手
    tim.kill() // 現在他可以 kill 了
    
    // tim.cry() // 一樣, 表面上他只是個殺手, 他其他事都不會做, 所以其他功能都不能使用
    
    
}
