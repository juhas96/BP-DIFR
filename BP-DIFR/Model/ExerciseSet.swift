//
//  ExerciseSet.swift
//  BP-DIFR
//
//  Created by jkbjhs on 09/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

struct ExerciseSet {
    let id: String? = nil
    var kg: Int
    var reps: Int
    
    init(kg: Int, reps: Int) {
        self.kg = kg
        self.reps = reps
    }
}
