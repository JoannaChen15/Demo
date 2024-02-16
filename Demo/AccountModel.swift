//
//  Accounts.swift
//  Demo
//
//  Created by 陳柔夆 on 2024/2/9.
//

import UIKit
import Foundation

struct Account {
    var avatar: UIImage?
    var name: String
    var followStatus: FollowStatus
    
    init(avatar: UIImage? = nil, name: String, followStatus: FollowStatus = .unfollow) {
        self.avatar = avatar
        self.name = name
        self.followStatus = followStatus
    }
}

var accounts: [Account] = [
    Account(avatar: UIImage(named: "Upstream"), name: "account0"),
    Account(avatar: UIImage(named: "Upstream-1"), name: "account1"),
    Account(avatar: UIImage(named: "Upstream-2"), name: "account2"),
    Account(avatar: UIImage(named: "Upstream-3"), name: "account3"),
    Account(avatar: UIImage(named: "Upstream-4"), name: "account4"),
    Account(avatar: UIImage(named: "Upstream-5"), name: "account5"),
    Account(avatar: UIImage(named: "Upstream-6"), name: "account6"),
    Account(avatar: UIImage(named: "Upstream-7"), name: "account7"),
    Account(avatar: UIImage(named: "Upstream-8"), name: "account8"),
    Account(avatar: UIImage(named: "Upstream-9"), name: "account9"),
    Account(avatar: UIImage(named: "Upstream-10"), name: "account10"),
    Account(avatar: UIImage(named: "Upstream-11"), name: "account11"),
    Account(avatar: UIImage(named: "Upstream-12"), name: "account12"),
    Account(avatar: UIImage(named: "Upstream-13"), name: "account13"),
    Account(avatar: UIImage(named: "Upstream-14"), name: "account14"),
    Account(avatar: UIImage(named: "Upstream-15"), name: "account15"),
    Account(avatar: UIImage(named: "Upstream-16"), name: "account16"),
    Account(avatar: UIImage(named: "Upstream-17"), name: "account17"),
    Account(avatar: UIImage(named: "Teamwork-1"), name: "account18"),
    Account(avatar: UIImage(named: "Teamwork-2"), name: "account19"),
    Account(avatar: UIImage(named: "Teamwork-3"), name: "account20"),
    Account(avatar: UIImage(named: "Teamwork-4"), name: "account21"),
    Account(avatar: UIImage(named: "Teamwork-5"), name: "account22"),
    Account(avatar: UIImage(named: "Teamwork-6"), name: "account23"),
    Account(avatar: UIImage(named: "Teamwork-7"), name: "account24"),
    Account(avatar: UIImage(named: "Teamwork-8"), name: "account25")
]
