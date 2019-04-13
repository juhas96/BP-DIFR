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

class RoutineNetworkService {
    
    let baseUrl: URL? = URL(string: "http://localhost:4545/")
    private var endPoint: String! = ""
    
    var routineArray = JSON()
    var routinesArray = [Routine]()
    
    func getAllRoutines(completion: @escaping ([Routine]?) -> Void) {
        self.endPoint = "routines"
        guard let routinesURL = URL(string: "https://difr.herokuapp.com/routines") else { return }
        
        Alamofire.request(routinesURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let req = try JSONDecoder().decode([Routine].self, from: data)
                completion(req)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
            
        }
    }
    
    func getRoutinesByUser(userUid: String, completion: @escaping ([Routine]?) -> Void) {
        self.endPoint = "routines"
        guard let routinesURL = URL(string: "https://difr.herokuapp.com/routines/user/\(userUid)") else { return }
        
        Alamofire.request(routinesURL,method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let req = try JSONDecoder().decode([Routine].self, from: data)
                completion(req)
            } catch let error {
                print(error)
                completion(nil)
            }
            
        }
    }
    
    func removeRoutine(routineId: Int) {
        guard let workoutsURL = URL(string: "https://difr.herokuapp.com/routines/\(String(describing: routineId))") else { return }
        Alamofire.request(workoutsURL, method: .delete).validate().response { (response) in
            print(response)
        }
    }
    
    func saveRoutine(routine: String) {
        guard let routinesURL = URL(string: "https://difr.herokuapp.com/routines") else { return }
        Alamofire.request(routinesURL, method: .post, parameters: [:], encoding: routine).responseJSON { (response) in
            debugPrint(response)
        }
    }
}
