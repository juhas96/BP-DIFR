//
//  Routine.swift
//  BP-DIFR
//
//  Created by jkbjhs on 29/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

struct Routine: Codable {
    
    var id: Int
    var name, notes: String
    var user: AppUser?
    var exercisesSets: [ExercisesSet]
    
    enum CodingKeys: String, CodingKey {
        case id, name, notes, user
        case exercisesSets = "exercises_sets"
    }
    
    init(id: Int, name: String, notes: String, user: AppUser, exercisesSets: [ExercisesSet]) {
        self.id = id
        self.name = name
        self.notes = notes
        self.user = user
        self.exercisesSets = exercisesSets
    }
}
