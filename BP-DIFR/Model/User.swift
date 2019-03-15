//
//  User.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation


struct User: Codable {
    var id: String? = nil
    let first_name: String
    var last_name: String
    var number_of_workouts: Int

    init(first_name: String, last_name: String, number_of_workouts: Int){
        self.first_name = first_name
        self.last_name = last_name
        self.number_of_workouts = number_of_workouts
    }
}
