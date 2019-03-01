//
//  Exercise.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

/**
 Model pre cvik ktorý sa ukladá do DB
 */
struct Exercise {
    let id: Int
//    let author: String
//    let category: Int
//    let description: String
//    let equipment: [String]
//    let imgPath: String
//    let muscles: [String]
    let name: String
    
    var dictionary:[String:Any] {
        return [
            "id": id,
//            "author": author,
//            "category": category,
//            "description": description,
            "name": name
        ]
    }
}

extension Exercise : DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let id = dictionary["id"] as? Int,
//        let author = dictionary["author"] as? String,
//        let category = dictionary["category"] as? Int,
//        let description = dictionary["description"] as? String,
        let name = dictionary["name"] as? String else { return nil }
        
        self.init(id: id, name: name)
    }
}
