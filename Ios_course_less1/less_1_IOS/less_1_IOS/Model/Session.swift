//
//  Session.swift
//  client_server_Ios
//
//  Created by elf on 21.03.2021.
//

import Foundation

class Session {
    var token : String = "token"
    var iserId : Int = 1
    
    private init() { }
    
    static let shared = Session()
}


