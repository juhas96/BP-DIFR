//
//  Exercise.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

/**
 Model pre cvik ktorý sa ukladá do DB
 */
struct Exercise: Codable {
    var id: String
    let category: Int
    let description: String
//    let imgPath: String
//    let muscles: [String]
    let name: String
    
    init(category: Int, description: String, name: String, id: String) {
        self.category = category
        self.description = description
        self.name = name
        self.id = id
    }
}
