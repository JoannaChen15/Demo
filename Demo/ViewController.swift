//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import Moya
import Result

enum MyService {
    case showUser(id: Int)
    case createUser(name: String, job: String)
    case updateUser(id: Int, name: String, job: String)
}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://reqres.in/api")! }
    var path: String {
        switch self {
        case .showUser(let id), .updateUser(let id, _, _):
            return "/users/\(id)"
        case .createUser(_, _):
            return "/users"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showUser:
            return .get
        case .createUser, .updateUser:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .showUser: // Send no parameters
            return .requestPlain
        case let .updateUser(_, name, job):  // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["name": name, "job": job], encoding: URLEncoding.queryString)
        case let .createUser(name, job): // Always send parameters as JSON in request body
            return .requestParameters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .showUser(let id):
            return "{\"id\": \(id), \"name\": \"Joanna\", \"job\": \"witcher\"}".utf8Encoded
        case .createUser(let name, let job):
            return "{\"id\": 100, \"name\": \"\(name)\", \"job\": \"\(job)\"}".utf8Encoded
        case .updateUser(let id, let name, let job):
            return "{\"id\": \(id), \"name\": \"\(name)\", \"job\": \"\(job)\"}".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data { Data(self.utf8) }
}

class ViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        let provider = MoyaProvider<MyService>.init(stubClosure: MoyaProvider<MyService>.immediatelyStub)
        provider.request(.showUser(id: 1)) { result in
            switch result {
            case let .success(response):
                do {
                    // 模擬伺服器回應
                    var responseJSON = try response.mapJSON()
                    print(responseJSON)
                } catch {
                    print("Error parsing response: \(error)")
                }

            case let .failure(error):
                print("Network error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
