//
//  EmailService.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import UIKit

class EmailService {
    
    private let network = EmailNetwork()
    
    /// 订阅邮件通知
    /// - Parameter email: 邮箱地址
    func subscribeEmailNotification(email: String, completion: @escaping(_ result : PandoraResult) -> ()) {
        if email == "" {
            return completion(.failed(error: PandoraError(code: PandoraError.e_Custom, errorMsg: "邮件不能为空")))
        }
        
        if !ValidateUtil.validateEmail(email) {
            return completion(.failed(error: PandoraError(code: PandoraError.e_Custom, errorMsg: "邮件格式不正确")))
        }
        
        network.request(.subscribeNotification(params: ["email" : email])) { (json) in
            let status = json["status"]
            print(status)
            completion(.ok(any: "订阅成功"))
        } failure: { (error) in
            completion(.failed(error: error))
        }
    }
}
