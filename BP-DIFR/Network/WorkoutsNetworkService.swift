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


extension JSON {
    public var date: Date! {
        get {
            if let str = self.string {
                return JSON.jsonDateFormatter.date(from: str)
            }
            return nil
        }
    }
    
    private static let jsonDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        return dateFormatter
    }()
}

class WorkoutsNetworkService {
    
    let baseUrl: URL? = URL(string: "http://localhost:4545/")
    private var endPoint: String! = ""
    
    var workoutArray = JSON()
    var workoutsArray = [Workout]()
    
    func getAllWorkouts(completion: @escaping ([Workout]?) -> Void) {
        self.endPoint = "workouts"
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
