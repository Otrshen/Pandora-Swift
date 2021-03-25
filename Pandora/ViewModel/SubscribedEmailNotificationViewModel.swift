//
//  SubscribedEmailNotificationViewModel.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/25.
//

import UIKit

class SubscribedEmailNotificationViewModel: NSObject {
    
    private let service = EmailService()

    public func queryAllSubscribedEmail(completion: @escaping(_ result : Array<Email>) -> ()) {
        service.querySubscribedEmail { (result) in
            switch result {
            case .ok(let arr):
                if let emails = arr as? Array<Email> {
                    completion(emails)
                } else {
                    SVProgressHUD.showError(withStatus: "转换类型错误")
                }
            case .failed(let error):
                SVProgressHUD.showError(withStatus: error.errorInfo)
            }
        }
    }
}
