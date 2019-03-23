//
//  WorkoutsNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 22/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class WorkoutsNetworkService {
    
    let baseUrl: URL? = URL(string: "http://localhost:4545/")
    private var endPoint: String! = ""
    
    var workoutArray = JSON()
    var workoutsArray = [Workout]()
    
    func getAllWorkouts(completion: @escaping ([Workout]?) -> Void) {
        self.endPoint = "workouts"
        guard let workoutsURL = URL(string: "http://localhost:4545/workouts") else { return }
        
        Alamofire.request(workoutsURL,method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.workoutArray = JSON(value)
                let wkArray = self.workoutArray.arrayValue
                for workout in wkArray {
                    let id = workout["id"].stringValue
                    let duration = workout["duration"].intValue
                    let start_date = workout["start_date"]
                    let end_date = workout["end_date"]
                    let name = workout["name"].stringValue
                    let notes = workout["notes"].stringValue
                    let user_id = workout["user_id"].stringValue
                    let kg_lifted_overall = workout["kg_lifted_overall"].intValue
//                    self.workoutsArray.append(Workout(id: id,duration: duration, start_date: start_date, end_date: end_date, name: name, notes: notes, user_id: user_id, kg_lifted_overall: kg_lifted_overall))
                }
                completion(self.workoutsArray)
            
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
        }
        
    }
}
}
