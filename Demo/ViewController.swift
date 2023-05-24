//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    let cityPickView = UIPickerView()
    let label = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cityPickView)
        cityPickView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
        cityPickView.delegate = self
        cityPickView.dataSource = self
        
        label.text = "台北市中正區"
        label.font = .systemFont(ofSize: 26)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(cityPickView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cities[row].name
        } else {
            let cityRow = pickerView.selectedRow(inComponent: 0)
            return cities[cityRow].districts[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                let districtsRow = pickerView.selectedRow(inComponent: 1)
                label.text = "\(cities[row].name)\(cities[row].districts[districtsRow].name)"
            } else {
                let cityRow = pickerView.selectedRow(inComponent: 0)
                label.text = "\(cities[cityRow].name)\(cities[cityRow].districts[row].name)"
            }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cities.count
        } else {
            let cityRow = pickerView.selectedRow(inComponent: 0)
            return cities[cityRow].districts.count
        }
    }
}

//定義 JSON 對應的 Decodable 型別
struct City: Decodable {
    let name: String
    let districts: [District]
}
struct District: Decodable {
    let zip: String
    let name: String
}

let cities: [City] = [
    City(name: "台北市", districts: [
        District(zip: "100", name: "中正區"),
        District(zip: "103", name: "大同區"),
        District(zip: "104", name: "中山區"),
        District(zip: "110", name: "信義區"),
        District(zip: "111", name: "松山區"),
        // 添加更多台北市行政區...
    ]),
    City(name: "新北市", districts: [
        District(zip: "200", name: "板橋區"),
        District(zip: "220", name: "新莊區"),
        District(zip: "221", name: "中和區"),
        District(zip: "223", name: "三峽區"),
        District(zip: "231", name: "新店區"),
        // 添加更多新北市行政區...
    ]),
    City(name: "桃園市", districts: [
        District(zip: "320", name: "中壢區"),
        District(zip: "324", name: "平鎮區"),
        District(zip: "325", name: "龍潭區"),
        District(zip: "330", name: "桃園區"),
        District(zip: "333", name: "八德區"),
        // 添加更多桃園市行政區...
    ])
]

//讀取 asset 裡的 JSON，將轉換後的 Decodable 型別資料存在 computed variable
//extension City {
//    static var data: [Self] {
//        guard let data = NSDataAsset(name: "taiwanDistricts")?.data else {
//            return []
//        }
//        return (try? JSONDecoder().decode([Self].self, from: data)) ?? []
//    }
//}
