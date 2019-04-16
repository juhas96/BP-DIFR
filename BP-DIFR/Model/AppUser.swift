//
//  User.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation


struct AppUser : Codable {
    
    var id: Int?
    var username, email, uid, profileImageUrl: String
    
    init(id: Int, username: String, email: String, uid: String, profileImageUrl: String) {
        self.id = id
        self.username = username
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
    }
    
}
