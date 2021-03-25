//
//  PandoraError.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

import UIKit

class PandoraError: NSObject, CustomNSError {
    /// 成功
    static let e_Svr_Ok = "1"
    /// 失败
    static let e_Svr_Fail = "-1"
    /// 参数错误
    static let e_ParamsError = "-2"
    /// 未知错误
    static let e_Unknown = "-3"
    /// 解析错误
    static let e_Parse = "-4"
    /// 空数据
    static let e_NullData = "-5"
    /// 自定义错误码
    static let e_Custom = "-100"
    
    
    /** -------------- 错误信息 --------------- */
    
    static let e_Unknown_Msg = "未知错误"
    static let e_Parse_Msg = "解析数据出错"
    
    /// 错误码
    var errorCode: String = PandoraError.e_Unknown
    /// 错误信息
    var errorInfo: String = PandoraError.e_Unknown_Msg
    /// 错误数据
    var errorData: String?
    
    /// 自定义错误码和错误信息
    /// - Parameters:
    ///   - errorCode: 自定义code
    ///   - errorInfo: 自定义错误信息
    init(errorCode: String = PandoraError.e_Unknown, errorInfo: String = PandoraError.e_Unknown_Msg) {
        self.errorCode = errorCode
        self.errorInfo = errorInfo
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - code: 错误码
    ///   - errorMsg: 错误信息
    init(code: String?, errorMsg: String? = nil) {
        super.init()
        
        handler(code: code, errorMsg: errorMsg, errorData: nil)
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - code: 错误码
    ///   - errorMsg: 错误信息
    ///   - errorData: 错误数据（自定义数据）
    init(code: String?, errorMsg: String? = nil, errorData: String? = nil) {
        super.init()
        
        handler(code: code, errorMsg: errorMsg, errorData: errorData)
    }
    
    // MARK: - private
    
    // 错误码和错误信息键值对
    private var errorCodeToMsgDict = [String : String]()
    
    // 本地错误码与错误信息对应关系
    private func initLocalError() {
        errorCodeToMsgDict = [
            PandoraError.e_ParamsError : "参数错误",
            PandoraError.e_Parse : "数据解析错误",
            PandoraError.e_NullData : "Data为空"
        ]
    }
    
    private func handler(code: String?, errorMsg: String?, errorData: String?) {
        initLocalError()
        
        if let co = code {
            self.errorCode = co
            if let msg = errorCodeToMsgDict[co] {
                self.errorInfo = msg
            } else {
                if let msg = errorMsg {
                    self.errorInfo = msg
                } else {
                    self.errorInfo = PandoraError.e_Unknown_Msg
                }
            }
            
            if let data = errorData {
                self.errorData = data
            }
        } else {
            self.errorCode = PandoraError.e_Unknown
            self.errorInfo = errorMsg == nil ? PandoraError.e_Unknown_Msg : errorMsg!
        }
    }
}
