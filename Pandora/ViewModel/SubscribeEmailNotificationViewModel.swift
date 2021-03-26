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
        SVProgressHUD.show()
        emailService.subscribeEmailNotification(email: email) { (result) in
            switch result {
            case .ok(let info):
                SVProgressHUD.dismiss()
                
                // 绑定极光别名
                JPUSHService.setAlias(email, completion: { (status, alias, _) in
                    if status == 0 {
                        print("别名绑定成功")
                    }
                }, seq: 1)
                
                SVProgressHUD.showSuccess(withStatus: info as? String)
            case .failed(let error):
                SVProgressHUD.showError(withStatus: error.errorInfo)
            }
        }
    }
    
}
