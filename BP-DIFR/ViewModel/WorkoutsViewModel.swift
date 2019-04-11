//
//  WorkoutsViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import FirebaseUI
import Alamofire
import SwiftyJSON
import Firebase

class WorkoutsViewModel: UIViewController {    
    
    @IBOutlet weak var tableView: UITableView!
    
    var workout: Workout!
    
    @IBAction func startEmptyWorkoutTapped(_ sender: Any) {
        performSegue(withIdentifier: "startWorkout", sender: workout)
    }
    
    var routinesArray = [Routine]()
    
    var routineService: RoutineNetworkService!
    
    var user: AppUser!
    
    
    func assigneFirUserToUser(user: User) -> AppUser {
        return AppUser(id: 999, username: user.displayName ?? "", email: user.email!, uid: user.uid)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if Auth.auth().currentUser != nil {
            self.user = assigneFirUserToUser(user: Auth.auth().currentUser!)
            print(user)
        } else {
            print("Current user is nil")
        }
        
        
        routineService = RoutineNetworkService()
        routineService.getRoutinesByUser(userUid: user.uid, completion: { (routines) in
            DispatchQueue.main.async {
                if let routines = routines {
                    self.routinesArray = routines
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(user)
        routineService.getRoutinesByUser(userUid: user.uid, completion: { (routines) in
            DispatchQueue.main.async {
                if let routines = routines {
                    self.routinesArray = routines
                    self.tableView.reloadData()
                }
            }
        })
        self.tableView.reloadData()
    }
    
    func startWorkout() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startWorkout" {
            let vc = segue.destination as! WorkoutViewModel
            vc.currentWorkout = sender as? Workout
        }
    }
    
    func createWorkoutForSegue(routine: Routine) -> Workout {
        user = AppUser(id: 999, username: "", email: "", uid: "")
        workout = Workout(id: 0, duration: 0, startDate: "", endDate: "", name: routine.name, notes: routine.notes, kgLiftedOverall: 0, user: user, exercisesSets: routine.exercisesSets)
        return workout
    }
}




// MARK: TableView
extension WorkoutsViewModel: UITableViewDelegate, UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routinesArray.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = routinesArray[indexPath.row].id
            routineService.removeRoutine(routineId: id)
            routinesArray.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(routinesArray[indexPath.row])
        let workout = createWorkoutForSegue(routine: routinesArray[indexPath.row])
        performSegue(withIdentifier: "startWorkout", sender: workout)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        
        let routine: Routine
        
        if(routinesArray.count != 0) {
            routine = routinesArray[indexPath.row]
            let exercises = createExerciseStringFromWorkout(routine: routine)
            cell.setRoutineName(routineName: routine.name)
            cell.setExercisesLabel(exercises: exercises)
        }
        
        return cell
    }
    
}



// MARK: Array konverzia
extension WorkoutsViewModel {
    
    func createExerciseStringFromWorkout(routine: Routine) -> String {
        
        var exercises = [Exercise]()
        var exercisesSets = [ExercisesSet]()
        
        // vytiahnem si vsetky Exercise Sety z Workoutu
        exercisesSets = routine.exercisesSets
        for exerciseSet in exercisesSets {
            exercises.append(exerciseSet.exercise!)
        }
        
        // vyfiltrujem na unikatne
        exercises = Array(Set<Exercise>(exercises))
        
        var exerciseNames = [String]()
        
        // Vytiahnem vsetky Exercise name
        for exercise in exercises {
            exerciseNames.append(exercise.name!)
        }
        
        var exerciseString = String()
        
        // Vytvorim jednoduchy string na zobrazenie cvikov v treningu
        for exerciseName in exerciseNames {
            exerciseString.append(contentsOf: exerciseName)
            exerciseString.append(", ")
        }
        
        return exerciseString
    }
}
