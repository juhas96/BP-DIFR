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
struct Exercise{
    let id:             String
    let category:       Int
    let description:    String
    let img_url:        String
    let name:           String
    
    init(id: String, category: Int, description: String, name: String, img_url: String) {
        self.id =           id
        self.category =     category
        self.description =  description
        self.name =         name
        self.img_url =      img_url
    }
}
