//
//  PandoraResult.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/23.
//

enum PandoraResult {
    /// 成功
    case ok(any: Any)
    /// 失败
    case failed(error: PandoraError)
}
