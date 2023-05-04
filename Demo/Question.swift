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
        text: "「橙香森林」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["基隆市", "苗栗縣", "台北市", "宜蘭縣"]
    ),
    Question(
        text: "「新山夢湖」位於台灣哪個縣市？",
        answerIndex: 3,
        options: ["台南市", "花蓮縣", "台中市", "新北市"]
    ),
    Question(
        text: "「望幽谷」位於台灣哪個縣市？",
        answerIndex: 0,
        options: ["基隆市", "高雄市", "台南市", "宜蘭縣"]
    ),
    Question(
        text: "「濛濛湖」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["南投縣", "新北市", "台北市", "基隆市"]
    ),
    Question(
        text: "「忘憂森林」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["花蓮縣", "台東縣", "南投縣", "嘉義縣"]
    ),
    Question(
        text: "「外埔忘憂谷」的起點位於台灣哪個縣市？",
        answerIndex: 3,
        options: ["嘉義縣", "南投縣", "花蓮縣", "台中市"]
    ),
    Question(
        text: "「龍崎牛埔泥岩農塘」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["屏東縣", "台南市", "高雄市", "宜蘭縣"]
    ),
    Question(
        text: "「柴山秘境海灘」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["台南市", "基隆市", "高雄市", "屏東縣"]
    ),
    Question(
        text: "「壽豐雲山水」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["屏東縣", "花蓮縣", "台東縣", "宜蘭縣"]
    ),
    Question(
        text: "「六十石山」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["屏東縣", "花蓮縣", "台東縣", "宜蘭縣"]
    ),
    Question(
        text: "「太麻里」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["屏東縣", "花蓮縣", "台東縣", "宜蘭縣"]
    ),
    Question(
        text: "「水牛坑」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["屏東縣", "花蓮縣", "新北市", "宜蘭縣"]
    ),
    Question(
        text: "「象鼻岩」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["屏東縣", "新北市", "台東縣", "宜蘭縣"]
    ),
    Question(
        text: "「老梅迷宮」位於台灣哪個縣市？",
        answerIndex: 0,
        options: ["新北市", "花蓮縣", "台東縣", "宜蘭縣"]
    ),
    Question(
        text: "「芹壁村」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["屏東縣", "花蓮縣", "連江縣", "宜蘭縣"]
    ),
    Question(
        text: "「沙美老街」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["屏東縣", "金門縣", "連江縣", "宜蘭縣"]
    ),
    Question(
        text: "「翡翠谷」位於台灣哪個縣市？",
        answerIndex: 1,
        options: ["屏東縣", "花蓮縣", "連江縣", "宜蘭縣"]
    ),
    Question(
        text: "「鳩之澤」位於台灣哪個縣市？",
        answerIndex: 3,
        options: ["屏東縣", "花蓮縣", "連江縣", "宜蘭縣"]
    ),
    Question(
        text: "「日落大道」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["台中市", "台東縣", "苗栗縣", "台南市"]
    ),
    Question(
        text: "「龍蝦洞」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["台中市", "台東縣", "屏東縣", "台南市"]
    ),
    Question(
        text: "「鱷魚島」位於台灣哪個縣市？",
        answerIndex: 0,
        options: ["新北市", "台東縣", "屏東縣", "宜蘭縣"]
    ),
    Question(
        text: "「石梯坪單面山」位於台灣哪個縣市？",
        answerIndex: 0,
        options: ["花蓮縣", "台東縣", "屏東縣", "宜蘭縣"]
    ),
    Question(
        text: "「正濱漁港」位於台灣哪個縣市？",
        answerIndex: 2,
        options: ["台中市", "台東縣", "屏東縣", "基隆市"]
    ),
    Question(
        text: "「水湳洞」位於台灣哪個縣市？",
        answerIndex: 3,
        options: ["台中市", "台東縣", "屏東縣", "新北市"]
    )
]

