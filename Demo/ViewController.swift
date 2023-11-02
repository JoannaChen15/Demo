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
            return "{\"id\": \(id), \"name\": \"Harry\", \"job\": \"witcher\"}".utf8Encoded
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    override func viewDidAppear(_ animated: Bool) {
        let provider = MoyaProvider<MyService>(plugins: [ModifyHeaderPlugin(myHeader: "MyheaderValue"), ModifyResultPlugin()])
        provider.request(.createUser(name: "James", job: "actor")) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
                if let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data) {
                    print("name:\(createUserResponse.name), job:\(createUserResponse.job), id:\(createUserResponse.id), myData:\(createUserResponse.myData)")
                }
            case .failure:
                print("error")
            }
        }
    }
}

struct ModifyHeaderPlugin: PluginType {
    let myHeader: String

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue(myHeader, forHTTPHeaderField: "MyHeader")
        return request
    }
}

struct ModifyResultPlugin: PluginType {
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            do {
                // 解析原始數據
                let jsonData = try response.mapJSON()
                
                // 添加自定義數據
                var customData = jsonData as? [String: Any] ?? [:]
                customData["myData"] = "myDataValue"
                
                // 將修改後的數據轉換為 Data
                let modifiedData = try JSONSerialization.data(withJSONObject: customData)
                
                // 創建包含修改後數據的新 Response
                let modifiedResponse = Response(statusCode: response.statusCode, data: modifiedData)
                return .success(modifiedResponse)
            } catch {
                return .failure(.underlying(error, response))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
