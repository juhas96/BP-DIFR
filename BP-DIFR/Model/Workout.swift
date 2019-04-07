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
    
    let id : Int
    var duration: Int
    var startDate, endDate, name, notes: String
    var kgLiftedOverall: Int
    let user: AppUser
    var exercisesSets: [ExercisesSet]
    
    enum CodingKeys: String, CodingKey {
        case id, duration
        case startDate = "start_date"
        case endDate = "end_date"
        case name, notes
        case kgLiftedOverall = "kg_lifted_overall"
        case user
        case exercisesSets = "exercises_sets"
    }
    
    init(id: Int, duration: Int, startDate: String, endDate: String, name: String, notes: String, kgLiftedOverall: Int, user: AppUser, exercisesSets: [ExercisesSet]) {
        self.id = id
        self.duration = duration
        self.startDate = startDate
        self.endDate = endDate
        self.name = name
        self.notes = notes
        self.kgLiftedOverall = kgLiftedOverall
        self.user = user
        self.exercisesSets = exercisesSets
    }
}
