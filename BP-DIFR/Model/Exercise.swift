//
//  Exercise.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

/**
 Model pre cvik ktorý sa ukladá do DB
 */
struct Exercise {
    let id: Int
    let exerciseName: String
    let exerciseCategory: String
    let bodyPart: String
    let note: String
    let img: String
}
