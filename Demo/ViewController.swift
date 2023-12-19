//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建观察者对象
        let observer = MyObserver()

        // 注册观察者监听通知
        NotificationCenter.default.addObserver(observer, selector: #selector(MyObserver.handleNotification(notification:)), name: .myNotification, object: self)

//        // 创建发布通知的对象
//        let notifier = NotificationCenterExample()
//
//        // 发布通知
//        notifier.postNotification()
        
        // 创建通知
        let notification = Notification(name: .myNotification, object: self, userInfo: ["data": "Hello, NotificationCenter!"])
        
        let notificationTest = Notification(name: .myNotification, object: nil, userInfo: ["data": "Hello, Test!"])
        
        // NotificationQueue
        // 将通知加入通知队列，设置延迟时间
//        let notificationQueue = NotificationQueue.default
//        notificationQueue.enqueue(notification, postingStyle: .whenIdle, coalesceMask: [.none], forModes: nil)
//
//        // 假设执行一些操作
//
//        // 执行 runLoop，以便通知能够被处理
//        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        
        // 发布通知
        NotificationCenter.default.post(notification)
        NotificationCenter.default.post(notificationTest)

        // 移除观察者（通常在对象销毁时执行）
        NotificationCenter.default.removeObserver(observer, name: .myNotification, object: nil)//removeObserver的參數object: 是nil時會移除所有name符合的對象
        
        NotificationCenter.default.post(notification)
        NotificationCenter.default.post(notificationTest)
    }
}

// 定义一个通知的名称
extension Notification.Name {
    static let myNotification = Notification.Name("MyNotification")
}

// 创建一个观察者类
class MyObserver {
    @objc func handleNotification(notification: Notification) {
        if let data = notification.userInfo?["data"] as? String {
            print("Received notification with data: \(data)")
        }
    }
}

// 現實情況下不太會自己創建一個通知的類
// 创建一个发布通知的类
//class NotificationCenterExample {
//    func postNotification() {
//        // 创建一个通知
//        let notification = Notification(name: .myNotification, object: nil, userInfo: ["data": "Hello, NotificationCenter!"])
//
//        // 发布通知
//        NotificationCenter.default.post(notification)
//    }
//}
