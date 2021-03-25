//
//  Networking.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import Moya
import SwiftyJSON

typealias EmailNetwork = Networking<EmailApi>

class Networking<T: TargetType> {
    
    private var provider : MoyaProvider<T>;
    
    // 超时时间
    private let requestTimeoutClosure = { (endpoint:Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            request.timeoutInterval = 30
            done(.success(request))
        } catch {
            return
        }
    }
    
    init() {
        self.provider = MoyaProvider<T>(requestClosure: requestTimeoutClosure, plugins:[NetworkLoggerPlugin()])
    }

    /// 请求方法：包括成功、服务器状态码不正确、失败回调
    ///
    /// - Parameters:
    ///   - target: 接口
    ///   - successCallback: 成功回调
    ///   - failureCallback: 失败回调
    func request(_ target: T,
                 success successCallback: @escaping(_ json: JSON) -> Void,
                 failure failureCallback: ((_ error: PandoraError) -> Void)? = nil)
    {
        provider.request(target) { result in
            switch result {
                case let .success(response): do {
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        do {
                            let json = try response.mapJSON()
                            let jsonObjc = JSON(json)
                            if jsonObjc["status"].stringValue == PandoraError.e_Svr_Ok { // 成功
                                successCallback(jsonObjc)
                            } else { // 返回结果错误
                                if let fail = failureCallback {
                                    let code = jsonObjc["code"].stringValue
                                    let errorMsg = jsonObjc["message"].stringValue
                                    let errorData = jsonObjc["errorData"].stringValue
                                
                                    fail(PandoraError(code: code, errorMsg: errorMsg, errorData: errorData))
                                }
                            }
                        } catch { // 数据转JSON出错
                            if let fail = failureCallback {
                                fail(PandoraError(code: PandoraError.e_Parse))
                            }
                        }
                    } catch { // 接口错误 如：404 500
                        if let fail = failureCallback {
                            fail(PandoraError(code: "\(response.statusCode)"))
                        }
                    }
                }

                case let .failure(error): do { // 网络错误 如：网络超时
                    if let fail = failureCallback {
                        fail(PandoraError(code: "\(error.errorCode)", errorMsg: error.errorDescription))
                    }
                }
            }
        }
    }
}

