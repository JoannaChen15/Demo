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
    Question(text: "ABC", answerIndex: 0, options: ["A", "B", "C", "D"]),
    Question(text: "123", answerIndex: 0, options: ["1", "2", "3", "4"]),
    Question(text: "abc", answerIndex: 0, options: ["a", "b", "c", "d"]),
    Question(text: "xyz", answerIndex: 0, options: ["x", "y", "z", "w"])
]
