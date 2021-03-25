//
//  EmailRes.swift
//  Pandora
//
//  Created by 申铭 on 2021/3/25.
//

import HandyJSON

class EmailRes: HandyJSON {

    var status: String?
    var data: Array<Email>?
    
    required init() {}
}

class Email: HandyJSON {
    var id: String?
    var email: String?
    
    required init() {}
}
