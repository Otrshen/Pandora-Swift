//
//  SubscribeEmailNotificationViewModel.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import UIKit

class SubscribeEmailNotificationViewModel {
    
    private let emailService = EmailService()

    /// 订阅邮件通知
    /// - Parameter email: 邮箱地址
    public func subscribeEmailNotification(email: String) {
        emailService.subscribeEmailNotification(email: email) { (result) in
            switch result {
            case .ok(let info):
                SVProgressHUD.showSuccess(withStatus: info as? String)
            case .failed(let error):
                SVProgressHUD.showError(withStatus: error.errorInfo)
            }
        }
    }
    
}
