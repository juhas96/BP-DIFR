//
//  User.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation


struct AppUser : Codable {
    static var shared = AppUser()
    var id: Int?
    var username, email, uid: String?
    private init () {}
}
