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
struct Exercise: Codable, Hashable{
    let id: Int?
    let description, name: String?
    let category: Int?
    let imgURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, description, name, category
        case imgURL = "img_url"
    }
    
    init(id: Int, description: String, name: String, category: Int, imgURL: String) {
        self.id = id
        self.description = description
        self.name = name
        self.category = category
        self.imgURL = imgURL
    }
}
