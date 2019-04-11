//
//  AddRoutineViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 01/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class AddRoutineViewModel: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var routineName: UITextField!
    @IBOutlet weak var routineNotes: UITextView!
    
    var exerciseSets = [ExercisesSet]()
    var user: AppUser!
    var routineNetworkService: RoutineNetworkService!
    
    var routine: Routine!
    
    var routineDb = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.user = assigneFirUserToUser(user: Auth.auth().currentUser!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(addExerciseToRoutine(notification:)), name: .addExerciseToWorkout, object: nil)
    }
    
    
    
    func assigneFirUserToUser(user: User) -> AppUser {
        return AppUser(id: 999, username: user.displayName ?? "", email: user.email!, uid: user.uid)
    }
        
    @objc func addExerciseToRoutine(notification: Notification) {
        var exerciseSet: ExercisesSet
        exerciseSet = notification.object as! ExercisesSet
        self.exerciseSets.append(exerciseSet)
        print(self.exerciseSets)
        self.tableView.reloadData()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        createRoutine()
        self.dismiss(animated: true, completion: nil)
    }
    
    func createRoutine() {
        if(routineName.text != nil) {
            self.routine  = Routine(id: 0, name: routineName.text!, notes: routineNotes.text, user: self.user, exercisesSets: exerciseSets)
            self.routineDb = convertRoutineToParameters(routine: self.routine)
            DispatchQueue.main.async {
                self.addRoutineToDatabase()
            }
        }
    }
}

extension AddRoutineViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicOneSetCell") as? ExerciseCellInNewRoutine else { return UITableViewCell() }
        cell.setExerciseName(exerciseName: (exerciseSets[indexPath.row].exercise?.name)!)
        return cell
    }
    
    
}

// MARK: NETWORK FUNC
extension AddRoutineViewModel {
    func convertRoutineToParameters(routine: Routine) -> String {
        var jsonString = String()
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(routine)
            jsonString = String(data: jsonData, encoding: .utf8)!
            
        }
        catch let error{
            print(error.localizedDescription)
        }
    
        return jsonString
    }
    
    func addRoutineToDatabase() {
        self.routineNetworkService = RoutineNetworkService()
        self.routineNetworkService.saveRoutine(routine: self.routineDb)
    }
}
