//
//  ExercisesNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 16/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExercisesNetworkService {
    let baseUrl: URL? = URL(string: "http://localhost:4545/")
    private var endPoint: String! = ""
    var exerciseArray = JSON()
    var exercisesArray = [Exercise]()
    
    func getAllExercises(completion: @escaping ([Exercise]?) -> Void) {
        self.endPoint = "exercises"
        guard let exercisesURL = URL(string: "http://localhost:4545/exercises") else { return }
        // Vytvorim si zakladne URL na GET pre vsetky cviky v DB
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
        guard let exercisesURL = URL(string: "http://localhost:4545/exercises") else { return }
        Alamofire.request(exercisesURL, method: .post, parameters: exercise, encoding: JSONEncoding.default).validate().response { (response) in
            print(response)
        }
    }
    
    func removeExercise(exerciseId: Int?) {
        guard let exercisesURL = URL(string: "http://localhost:4545/exercises/\(exerciseId)") else { return }
        Alamofire.request(exercisesURL, method: .delete).validate().response { (response) in
            print(response)
        }
    }
}

    

