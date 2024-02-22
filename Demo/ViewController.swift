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
    let area = UILabel()
    let pageTitle = UILabel()
    
    let picture = UIImageView()
    let text = UILabel()
    
    var imageUrls = [URL]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageTitle.text = "要去哪裡玩🥳"
        pageTitle.font = .systemFont(ofSize: 26)
        view.addSubview(pageTitle)
        pageTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
        }
        
        area.text = "臺北市中正區"
        area.font = .systemFont(ofSize: 26)
        view.addSubview(area)
        area.snp.makeConstraints { make in
            make.top.equalTo(pageTitle.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(cityPickView)
        cityPickView.snp.makeConstraints { make in
            make.top.equalTo(area.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        configUI()
        
        cityPickView.delegate = self
        cityPickView.dataSource = self
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
                area.text = "\(cities[row].name)\(cities[row].districts[districtsRow].name)"
            } else {
                let cityRow = pickerView.selectedRow(inComponent: 0)
                area.text = "\(cities[cityRow].name)\(cities[cityRow].districts[row].name)"
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

//let cities: [City] = [
//    City(name: "台北市", districts: [
//        District(zip: "100", name: "中正區"),
//        District(zip: "103", name: "大同區"),
//        District(zip: "104", name: "中山區"),
//        District(zip: "110", name: "信義區"),
//        District(zip: "111", name: "松山區"),
//        // 添加更多台北市行政區...
//    ]),
//    City(name: "新北市", districts: [
//        District(zip: "200", name: "板橋區"),
//        District(zip: "220", name: "新莊區"),
//        District(zip: "221", name: "中和區"),
//        District(zip: "223", name: "三峽區"),
//        District(zip: "231", name: "新店區"),
//        // 添加更多新北市行政區...
//    ]),
//    City(name: "桃園市", districts: [
//        District(zip: "320", name: "中壢區"),
//        District(zip: "324", name: "平鎮區"),
//        District(zip: "325", name: "龍潭區"),
//        District(zip: "330", name: "桃園區"),
//        District(zip: "333", name: "八德區"),
//        // 添加更多桃園市行政區...
//    ])
//]

//讀取 asset 裡的 JSON，將轉換後的 Decodable 型別資料存在 computed variable
extension City {
    static var data: [Self] {
        guard let data = NSDataAsset(name: "taiwan_districts")?.data else {
            return []
        }
        return (try? JSONDecoder().decode([Self].self, from: data)) ?? []
    }
}

extension ViewController {
    func configUI() {
        view.addSubview(picture)
        picture.backgroundColor = .tintColor
        picture.contentMode = .scaleAspectFit
        
        
        if let requestUrlString = URL(string: "https://itunes.apple.com/search?term=田馥甄&media=music&country=tw") {
            var request = URLRequest(url: requestUrlString)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.httpBody
        }
        
        if let urlString = "https://itunes.apple.com/search?term=田馥甄&media=music&country=tw".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data,
                   let response = response as? HTTPURLResponse,
                   response.statusCode == 200,
                   error == nil {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    do {
                        let song = try decoder.decode(Song.self, from: data)
                        for song in song.results {
                            self.imageUrls.append(song.artworkUrl100)
                        }
                        print(song.results[0].releaseDate)
                    } catch {
                        print(error)
                    }
                }
                
                URLSession.shared.dataTask(with: self.imageUrls[0]) { data, response, error in
                    if let data,
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.picture.image = image
                        }
                    }
                }.resume()
                
            }.resume()
        }
    
        picture.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(cityPickView.snp.bottom).offset(30)
        }
    }
}
