//
//  GetExerciseResponse.swift
//  BP-DIFR
//
//  Created by jkbjhs on 16/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

struct GetExerciseResponse {
    
    
    let exercises: [Exercise]
    
    init(json: JSON) throws {
        guard let results = json["results"] as? [JSON] else { throw NetworkingError.badNetworkingStuff }
        let exercises = results.map{Exercise(json: $0 )}.compactMap{ $0 }
        self.exercises = exercises
    }
    
    
    
}
