//
//  EmailApi.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import Moya

let kUrl = "http://127.0.0.1:8886/pandora"

enum EmailApi {
    case subscribeNotification(params: [String : Any])
    case queryAllSubscribedEmail
}

extension EmailApi: TargetType {
    var baseURL: URL {
        return URL(string: kUrl)!
    }
    
    var path: String {
        switch self {
        case .subscribeNotification, .queryAllSubscribedEmail:
            return "/email/subscribe/notification"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .queryAllSubscribedEmail:
                return .get
            case .subscribeNotification:
                return .post
        }
    }
    
    var sampleData: Data {
        switch self {
            case .subscribeNotification:
                return "单元测试".data(using: String.Encoding.utf8)!
            default:
                return "单元测试".data(using: String.Encoding.utf8)!
        }
        
    }
    
    var task: Task {
        switch self {
        case .subscribeNotification(let p):
            return .requestParameters(parameters: p, encoding: URLEncoding.default)
        case .queryAllSubscribedEmail:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/x-www-form-urlencoded",
                "AccessToken" : "shenming"]
    }
    

}
