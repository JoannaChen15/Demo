//
//  MyStory.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import Foundation

let story = Story(pages: [
    StoryPage( // 0
        text:"晚餐想吃什麼",
        choices: [
            Choice(text: "飯", destination: 1),
            Choice(text: "麵", destination: 2)
        ]
    ),
    StoryPage( // 1
        text:"喜歡什麼類型",
        choices: [
            Choice(text: "日式", destination: 3),
            Choice(text: "泰式", destination: 4)
        ]
    ),
    StoryPage( // 2
        text:"喜歡什麼類型",
        choices: [
            Choice(text: "日式", destination: 5),
            Choice(text: "韓式", destination: 6)
        ]
    ),
    StoryPage( // 3
        text:
        "咖哩飯",
        choices: []
    ),
    StoryPage( // 4
        text:
        "打拋豬飯",
        choices: []
    ),
    StoryPage( // 5
        text:
        "拉麵",
        choices: []
    ),
    StoryPage( // 6
        text:
        "部隊鍋",
        choices: []
    )
])
