//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.backgroundColor = .tintColor
        tableView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//定義抓資料的fetchMenu
func fetchMenu() {
    let urlString = "https://api.airtable.com/v0/appxrciNhGMQw3sSj/drink"
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                let decoder = JSONDecoder()
                do {
                    let napTea = try decoder.decode(NapTea.self, from: data)
                    print(napTea)
//                    DispatchQueue.main.async {
//                        self.allDrinks = menuResponse.records
//                        for drink in self.allDrinks {
//                            switch drink.fields.classification {
//                            case "#Original TEA 原茶系列":
//                                self.teaDrinks.append(drink)
//                            case "#Classic MILK TEA 經典奶茶":
//                                self.milkteaDrinks.append(drink)
//                            case "#Double FRUIT 雙重水果":
//                                self.fruitDrinks.append(drink)
//                            case "#Fresh MILK 鮮奶系列":
//                                self.milkDrinks.append(drink)
//                            case "#Cheese MILK FOAM 芝士奶蓋":
//                                self.cheeseDrinks.append(drink)
//                            default:
//                                break
//                            }
//                        }
//
//                        //載完資料後filteredDrinks先出現的是原萃系列的品項
//                        self.filteredDrinks = self.teaDrinks
//                        //如果沒有reload data，表格不會更新，只會看到一片空白
//                        self.tableView.reloadData()
//                    }
                    print("get data")
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        print(indexPath)
        return cell
    }
}
