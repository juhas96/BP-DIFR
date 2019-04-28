//
//  WorkoutsNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 22/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire

class WorkoutsNetworkService {
    
    func getAllWorkouts(completion: @escaping ([Workout]?) -> Void) {
        guard let workoutsURL = URL(string: "https://difr.herokuapp.com/workouts") else { return }
        Alamofire.request(workoutsURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let req = try JSONDecoder().decode([Workout].self, from: data)
                completion(req)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func getWorkoutsByUser(userUid: String, completion: @escaping ([Workout]?) -> Void) {
        guard let workoutsURL = URL(string: "https://difr.herokuapp.com/workouts/user/\(userUid)") else { return }
        Alamofire.request(workoutsURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let req = try JSONDecoder().decode([Workout].self, from: data)
                completion(req)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func removeWorkout(workoutId: Int?) {
        guard let workoutsURL = URL(string: "https://difr.herokuapp.com/workouts/\(String(describing: workoutId))") else { return }
        Alamofire.request(workoutsURL, method: .delete).validate().response { (response) in
            print(response)
        }
    }
    
    func saveWorkout(workout: String) {
        guard let workoutsURL = URL(string: "https://difr.herokuapp.com/workouts") else { return }
        Alamofire.request(workoutsURL, method: .post, parameters: [:], encoding: workout).responseJSON { (response) in
            debugPrint(response)
        }
    }
}
