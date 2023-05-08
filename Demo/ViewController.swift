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
        test()
    }
}

// 任務調度中心, 負責指派任務
class MissionCenter {
    // 任務編號 M-1 ~ M-100
    private var missions: Array<String> = {
        let count = Array(0 ..< 20)
        return count.map { "M-\($0)" }
    }()
    
    private var freeTaxis: Array<Taxi> = []
    
    // 註冊新的車子
    func registe(taxi: Taxi) {
        freeTaxis.append(taxi)
        taxi.delegate = self
    }
    
    // 開始營業
    func openForBusiness() {
        // 先把所有車子派出去執行任務
        for taxi in freeTaxis {
            guard missions.count > 0 else { break }
            taxi.missionStart(mission: missions.removeFirst())
        }
    }
}

// 車子完成任務以後, 給他下一份任務
extension MissionCenter: TaxiProtocol {
    func missionCompleted(taxi: Taxi) {
        guard missions.count > 0 else { return }
        taxi.missionStart(mission: missions.removeFirst())
    }
}


// 車子的 delegate 負責通知車子已經完成任務
protocol TaxiProtocol: AnyObject {
    func missionCompleted(taxi: Taxi)
}

// 計程車
class Taxi {
    let carID: String
    
    weak var delegate: TaxiProtocol?
    
    init(carID: String) {
        self.carID = carID
    }
    
    func missionStart(mission: String) {
        print("\(carID) doing mission: \(mission) >>>")
        
        // 1~3 後完成任務
        let missionTime = TimeInterval.random(in: 1 ..< 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + missionTime,
                                      execute: {
            print("\(self.carID) complete mission: \(mission) |||")
            self.delegate?.missionCompleted(taxi: self)
        })
    }
}

// 開始測試
let missionCenter = MissionCenter()
func test() {
    let taxiNames: Array<String> = [
        "星宇", "長榮", "華航", "國泰", "復興"
    ]
    let taxis = taxiNames.map { Taxi(carID: $0) }
    taxis.forEach {
        missionCenter.registe(taxi: $0)
    }
    
    missionCenter.openForBusiness()
}
