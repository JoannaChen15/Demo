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
    ),
    Question(
        text: "以下哪一個不是水果？",
        answerIndex: 3,
        options: ["蘋果", "香蕉", "草莓", "西蘭花"]
    ),
    Question(
        text: "在哪個星球可以找到綠巨人浩克？",
        answerIndex: 2,
        options: ["火星", "木星", "地球", "金星"]
    ),
    Question(
        text: "誰是《哈利波特》系列小說中的主角？",
        answerIndex: 0,
        options: [
            "哈利·波特",
            "赫敏·格蘭傑",
            "羅恩·衛斯理",
            "阿不思·鄧不利多"
        ]
    ),
    Question(
        text: "哪一個城市是台灣的首都？",
        answerIndex: 1,
        options: [
            "高雄",
            "台北",
            "台中",
            "新北"
        ]
    ),
    Question(
        text: "哪一種是世界上最大的海龜？",
        answerIndex: 2,
        options: [
            "綠蠵龜",
            "赤蠵龜",
            "革龜",
            "鱉龜"
        ]
    ),
    Question(
        text: "誰是樂團 Queen 的主唱？",
        answerIndex: 1,
        options: [
            "Freddie Mercury",
            "John Lennon",
            "Elton John",
            "David Bowie"
        ]
    ),
    Question(
        text: "哪一個不是日本的都市？",
        answerIndex: 2,
        options: [
            "東京",
            "京都",
            "首爾",
            "大阪"
        ]
    ),
    Question(
        text: "誰是《神鬼傳奇》系列電影的男主角？",
        answerIndex: 0,
        options: [
            "湯姆·克魯斯",
            "布萊德·彼特",
            "麥特·戴蒙",
            "小勞勃·唐尼"
        ]
    ),
    Question(
        text: "蜘蛛的蛛絲是由哪個部位分泌出來的？",
        answerIndex: 0,
        options: [
            "腹部",
            "頭部",
            "胸部",
            "腿部"
        ]
    ),
    Question(
        text: "哪一個國家沒有聯合國會員資格？",
        answerIndex: 3,
        options: [
            "美國",
            "中國",
            "俄羅斯",
            "台灣"
        ]
    ),
    Question(
        text: "以下哪個國家不是歐洲國家？",
        answerIndex: 3,
        options: [
            "義大利",
            "西班牙",
            "德國",
            "巴西"
        ]
    ),
    Question(
        text: "下列哪一種綠色蔬菜中鐵質含量最高？",
        answerIndex: 1,
        options: [
            "小白菜",
            "菠菜",
            "豆芽菜",
            "芥菜"
        ]
    ),
    Question(
        text: "哪一個不是動物？",
        answerIndex: 2,
        options: [
            "貓",
            "狗",
            "桌子",
            "獅子"
        ]
    )
]

