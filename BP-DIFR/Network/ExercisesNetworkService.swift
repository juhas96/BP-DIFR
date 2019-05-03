//
//  ExercisesNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 16/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire

class ExercisesNetworkService {
    
    func getAllExercises(completion: @escaping ([Exercise]?) -> Void) {
        guard let exercisesURL = URL(string: "https://difr.herokuapp.com/exercises") else { return }
        Alamofire.request(exercisesURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let req = try decoder.decode([Exercise].self, from: data)
                completion(req)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func createExercise(exercise: Parameters) {
        guard let exercisesURL = URL(string: "https://difr.herokuapp.com/exercises") else { return }
        Alamofire.request(exercisesURL, method: .post, parameters: exercise, encoding: JSONEncoding.default).validate().response { (response) in
            print(response)
        }
    }
    
    func removeExercise(exerciseId: Int?) {
        guard let exercisesURL = URL(string: "https://difr.herokuapp.com/exercises/\(String(describing: exerciseId))") else { return }
        Alamofire.request(exercisesURL, method: .delete).validate().response { (response) in
            print(response)
        }
    }
    
    func getExercisesByType(exerciseType: String? ,completion: @escaping ([Exercise]?) -> Void) {
        guard let exercisesURL = URL(string: "https://difr.herokuapp.com/exercises/\(String(describing: exerciseType))") else { return }
        Alamofire.request(exercisesURL, method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let req = try decoder.decode([Exercise].self, from: data)
                completion(req)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}



