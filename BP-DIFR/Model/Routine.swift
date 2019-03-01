//
//  Routine.swift
//  BP-DIFR
//
//  Created by jkbjhs on 01/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

class Routine {
    let id: Int
    let name: String
    let exercises: [Exercise]
    
    init(id: Int, name: String, exercises: [Exercise]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}
