//
//  ExerciseSet.swift
//  BP-DIFR
//
//  Created by jkbjhs on 09/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

struct ExercisesSet : Codable {
    var kg, reps: Int?
    var exercise: Exercise?
    var user: AppUser?
}   
