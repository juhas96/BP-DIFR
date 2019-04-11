//
//  ExercisesSetsNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 07/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire

class ExercisesSetsNetworkService {
//    var exercisesSetsArray = [ExercisesSet]()
    
    // Vrati vsetky exerciseSets podla usera a cviku
    func getAllExerciseSetsByUser(userUid: String, exerciseId: Int, completion: @escaping ([ExercisesSet]?) -> Void) {
        guard let exercisesURL = URL(string: "http://localhost:4545/exercise_sets/byuser/\(userUid)&\(exerciseId)") else { return }
        Alamofire.request(exercisesURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let req = try decoder.decode([ExercisesSet].self, from: data)
                completion(req)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}