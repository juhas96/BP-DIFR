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
struct Workout {
    let id: String? = nil
    var duration: Int
    var start_date: Date
    var end_date: Date
    var name: String
    var notes: String
    var user_id: String
    var kg_lifted_overall: Int
    
    init(duration: Int, start_date: Date, end_date: Date, name: String, notes: String, user_id: String, kg_lifted_overall: Int) {
        self.duration = duration
        self.start_date = start_date
        self.end_date = end_date
        self.name = name
        self.notes = notes
        self.user_id = user_id
        self.kg_lifted_overall = kg_lifted_overall
    }
}
