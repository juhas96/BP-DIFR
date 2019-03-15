//
//  Exercise.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

/**
 Model pre cvik ktorý sa ukladá do DB
 */
<<<<<<< HEAD
struct Exercise: Codable {
    var id: String
    let category: Int
    let description: String
=======
struct Exercise {
    let id: Int
//    let author: String
//    let category: Int
//    let description: String
//    let equipment: [String]
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
//    let imgPath: String
//    let muscles: [String]
    let name: String
    
<<<<<<< HEAD
    init(category: Int, description: String, name: String, id: String) {
        self.category = category
        self.description = description
        self.name = name
        self.id = id
=======
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
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
    }
}
