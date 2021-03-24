//
//  ValidateUtil.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import Foundation

class ValidateUtil {
    /// 邮箱格式校验
    ///
    /// - Parameter email: 邮箱
    /// - Returns: 是否正确
    class func validateEmail(_ email: String) -> Bool {
        let regex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
}
