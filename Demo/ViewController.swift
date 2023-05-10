//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let animalTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(animalTableView)
        animalTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.center.equalToSuperview()
        }
        
        animalTableView.delegate = self
        animalTableView.dataSource = self
        
        animalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "animalCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = animals[indexPath.row].emoji
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let animal = animals[indexPath.row]
        print("選擇的是 \(animal)")
        let detailController = AnimalDetailViewController()
        detailController.fact.text = animal.facts
        self.present(detailController, animated: true)
//        self.navigationController?.pushViewController(detailController, animated: true)
    }
}


struct Animal {
    let emoji: String
    let name: String
    let facts: String
    let sound: String
}

let animals = [
    Animal(emoji: "🐶", name: "狗", facts: "狗是人類最早訓練的家畜之一", sound: "汪汪汪"),
    Animal(emoji: "🐱", name: "貓", facts: "貓有一種叫做“頑皮病”的疾病，會讓它們忽然間變得非常活躍", sound: "喵喵喵"),
    Animal(emoji: "🐭", name: "老鼠", facts: "老鼠是世界上最普遍的哺乳動物之一", sound: "吱吱吱"),
    Animal(emoji: "🐹", name: "仓鼠", facts: "仓鼠在澳大利亚是一種保護動物", sound: "咕咕咕"),
    Animal(emoji: "🐰", name: "兔子", facts: "兔子是唯一會因為吃草而嘔吐的哺乳動物", sound: "叽叽叽"),
    Animal(emoji: "🦊", name: "狐狸", facts: "狐狸是最聰明的哺乳動物之一，甚至會用鏟子來挖洞", sound: "哞哞哞"),
    Animal(emoji: "🐻", name: "熊", facts: "熊有四種：北極熊、棕熊、黑熊和熊猫", sound: "嗷嗷嗷"),
    Animal(emoji: "🐼", name: "熊貓", facts: "熊貓只有在中國才有，且數量極為稀少", sound: "哼哼哼"),
    Animal(emoji: "🐨", name: "袋鼠", facts: "袋鼠能跳得比它看起來的大更遠，最遠可達 10 米", sound: "咕噜咕噜"),
    Animal(emoji: "🐯", name: "老虎", facts: "老虎是哺乳動物界唯一有斑點的動物", sound: "咆哮咆哮")
]
