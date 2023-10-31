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
        let provider = MoyaProvider<MyService>(plugins: [RequestAlertPlugin(viewController: self)])
        provider.request(.createUser(name: "James", job: "actor")) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                print(statusCode)
                if let createUserResponse = try? JSONDecoder().decode(CreateUserResponse.self, from: data) {
                    print("name:\(createUserResponse.name), job:\(createUserResponse.job), id:\(createUserResponse.id)")
                }
            case .failure:
                print("error")
            }
        }
    }
}

final class RequestAlertPlugin: PluginType {

    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func willSend(_ request: RequestType, target: TargetType) {
        //make sure we have a URL string to display
        guard let requestURLString = request.request?.url?.absoluteString else { return }

        //create alert view controller with a single action
        let alertViewController = UIAlertController(title: "Sending Request", message: requestURLString, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        //and present using the view controller we created at initialization
        viewController.present(alertViewController, animated: true)
    }
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        //only continue if result is a failure
        guard case Result.failure(_) = result else { return }

        //create alert view controller with a single action and messing displaying status code
        let alertViewController = UIAlertController(title: "Error", message: "Request failed with status code: \(result.error?.response?.statusCode ?? 0)", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        //and present using the view controller we created at initialization
        viewController.present(alertViewController, animated: true)
    }
}
