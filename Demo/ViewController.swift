//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    let cities = City.data
    let cityPickView = UIPickerView()
    let label = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cityPickView)
        cityPickView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(300)
        }
        
        cityPickView.delegate = self
        cityPickView.dataSource = self
        
        label.text = "test"
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
            #warning("index out of range")
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
//讀取 asset 裡的 JSON，將轉換後的 Decodable 型別資料存在 computed variable
extension City {
    static var data: [Self] {
        var districtData = [Self]()
        if let data = NSDataAsset(name: "taiwanDistricts")?.data {
            do {
                districtData = try JSONDecoder().decode([Self].self, from: data)
            } catch {
                print(error)
            }
            
        }
        return districtData
    }
}
