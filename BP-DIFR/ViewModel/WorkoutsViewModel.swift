//
//  WorkoutsViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import SwiftyJSON

class WorkoutsViewModel: UIViewController {    
    
    @IBOutlet weak var tableView: UITableView!
    
    var workoutsArray = [Workout]()
    
    var workoutService: WorkoutsNetworkService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutService = WorkoutsNetworkService()
        workoutService.getAllWorkouts { (workouts) in
            DispatchQueue.main.async {
                if let workouts = workouts {
                    self.workoutsArray = workouts
                    self.tableView.reloadData()
                }
            }
        }
    }
}





extension WorkoutsViewModel: UITableViewDelegate, UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsArray.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = workoutsArray[indexPath.row].id
            workoutService.removeWorkout(workoutId: id)
            workoutsArray.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        
        let workout: Workout
        
        if(workoutsArray.count != 0) {
            workout = workoutsArray[indexPath.row]
            let exercises = createExerciseStringFromWorkout(workout: workout)
            cell.setRoutineName(routineName: workout.name)
            cell.setExercisesLabel(exercises: exercises)
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    func createExerciseStringFromWorkout(workout: Workout) -> String {

        var exercises = [Exercise]()
        var exercisesSets = [ExercisesSet]()
        
        // vytiahnem si vsetky Exercise Sety z Workoutu
        exercisesSets = workout.exercisesSets
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
