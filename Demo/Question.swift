//
//  Question.swift
//  Demo
//
//  Created by 譚培成 on 2023/5/3.
//

import Foundation

struct Question {
    let text: String
    let answerIndex: Int
    let options: [String]
}

let questions: [Question] = [
    Question(
        text: "Abundance",
        answerIndex: 1,
        options: ["放棄", "豐富", "慷慨", "貧困"]
    ),
    Question(
        text: "Crisis",
        answerIndex: 3,
        options: ["機會", "成就", "挑戰", "危機"]
    ),
    Question(
        text: "Diligent",
        answerIndex: 2,
        options: ["優雅", "忠誠", "勤奮", "耐心"]
    ),
    Question(
        text: "Enthusiastic",
        answerIndex: 1,
        options: ["舒適", "熱情", "運動", "災難"]
    ),
    Question(
        text: "Generous",
        answerIndex: 3,
        options: ["普通的", "天才", "世代", "慷慨"]
    ),
    Question(
        text: "Honest",
        answerIndex: 0,
        options: ["誠實", "幸運", "樂觀", "甜蜜"]
    ),
    Question(
        text: "Innovative",
        answerIndex: 2,
        options: ["科技", "明亮", "創新", "悅耳"]
    ),
    Question(
        text: "Judicious",
        answerIndex: 1,
        options: ["輕率", "明智", "懦弱", "刺激"]
    ),
    Question(
        text: "Knowledgeable",
        answerIndex: 0,
        options: ["博學", "網路", "認識", "故意地"]
    ),
    Question(
        text: "Loyal",
        answerIndex: 3,
        options: ["閒混", "在地的", "法律", "忠誠"]
    ),
    Question(
        text: "Modest",
        answerIndex: 1,
        options: ["時尚", "謙虛", "自大", "中間"]
    ),
    Question(
        text: "Noble",
        answerIndex: 0,
        options: ["高尚", "詐騙", "興趣", "平衡"]
    ),
    Question(
        text: "Optimistic",
        answerIndex: 1,
        options: ["悲觀", "樂觀", "完美", "堅持"]
    ),
    Question(
        text: "Passionate",
        answerIndex: 2,
        options: ["通行", "耐心", "熱情", "鈍化的"]
    ),
    Question(
        text: "Resourceful",
        answerIndex: 0,
        options: ["足智多謀", "回響地", "使分解的", "斷然地"]
    )
    // 添加更多题目...
]
