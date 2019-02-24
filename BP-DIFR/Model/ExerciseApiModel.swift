//
//  ExerciseApiModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 24/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

// Struktura cviku z API ktory sa dotiahne
struct ExerciseApiModel: Decodable {
    let id: Int?
    let description: String?
    let name: String?
    let category: Int?
//    let muscles: Int?
}
