//
//  StoryModels.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import Foundation

struct Choice {
    let text: String
    let destination: Int
}

struct StoryPage {
    let text: String
    let choices: [Choice]
}

struct Story {
    let pages: [StoryPage]
}
