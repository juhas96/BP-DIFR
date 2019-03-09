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
    let exercises: [Exercise]
    let name: String
    let duration: Date?
    let startTime: Date?
    let endTime: Date?
    let notes: String?
    let kgLifted: Int?
}
