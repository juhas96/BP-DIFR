//
//  User.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? {get set}
}

struct User: Codable, Identifiable {
    var id: String? = nil
    let name: String
    var age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}
