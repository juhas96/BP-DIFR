//
//  Workout.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

/**
 Model pre tréning
 */
struct Workout: Codable {
    
    let id, duration: Int
    let startDate, endDate, name, notes: String
    let kgLiftedOverall: Int
    let user: User
    let exercisesSets: [ExercisesSet]
    
    enum CodingKeys: String, CodingKey {
        case id, duration
        case startDate = "start_date"
        case endDate = "end_date"
        case name, notes
        case kgLiftedOverall = "kg_lifted_overall"
        case user
        case exercisesSets = "exercises_sets"
    }

    
    
}
