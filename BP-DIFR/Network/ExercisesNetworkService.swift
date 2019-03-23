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
            switch response.result {
            case .success(let value):
                self.exerciseArray = JSON(value)
                let exArray = self.exerciseArray.arrayValue
                for exercise in exArray {
                    let id = exercise["id"].stringValue
                    let category = exercise["category"].intValue
                    let name = exercise["name"].stringValue
                    let description = exercise["description"].stringValue
                    let img_url = exercise["img_url"].stringValue
                    self.exercisesArray.append(Exercise(id: id, category: category, description: description, name: name, img_url: img_url))
                }
                completion(self.exercisesArray)

            case .failure(let error):
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
    
    func removeExercise(exerciseId: String) {
        guard let exercisesURL = URL(string: "http://localhost:4545/exercises/\(exerciseId)") else { return }
        Alamofire.request(exercisesURL, method: .delete).validate().response { (response) in
            print(response)
        }
    }
}

    

