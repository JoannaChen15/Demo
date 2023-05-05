//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    let tableView = UITableView()
    
    let sectionModels: Array<SectionModel> = [
        SectionModel(auth: "田馥甄",
                  songs: [
                    "小幸運",
                    "愛情字典",
                    "日常",
                    "非你莫屬",
                    "良人",
                    "阿飛的小蝴蝶",
                    "前男友",
                    "旅行的意義",
                    "我的秘密",
                    "雨夜花",
                  ]),
        SectionModel(auth: "周杰倫",
                  songs: [
                    "告白氣球",
                    "晴天",
                    "聽媽媽的話",
                    "稻香",
                    "七里香",
                    "青花瓷",
                    "說好不哭",
                    "不能說的秘密",
                    "安靜",
                    "夜曲",
                  ]),
        SectionModel(auth: "五月天",
                  songs: [
                    "突然好想你",
                    "倔強",
                    "戀愛ing",
                    "知足",
                    "幾分之幾",
                    "擁抱",
                    "星空",
                    "溫柔",
                    "我不願讓你一個人",
                    "入陣曲",
                  ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(MyCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CellHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: "header")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionModels[section].songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCell
        let sectionModel = sectionModels[indexPath.section]
        cell.title.text = sectionModel.songs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "header") as! CellHeaderView
        let sectionModel = sectionModels[section]
        header.title.text = sectionModel.auth
        return header
    }
}

struct SectionModel {
    let auth: String
    let songs: Array<String>
}


class MyCell: UITableViewCell {
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(30)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class CellHeaderView: UITableViewHeaderFooterView {
    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
