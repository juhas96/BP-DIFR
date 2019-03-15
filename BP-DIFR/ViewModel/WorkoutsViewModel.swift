//
//  WorkoutsViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import LNPopupController
import Parse

class WorkoutsViewModel: UIViewController {    
    
    var routines = [PFObject]()
    var exercises = [PFObject]()
    var user: PFUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

<<<<<<< HEAD
=======

}

var dictionary:[String:Any] {
    return [
        "id": 5,
        //            "author": author,
        //            "category": category,
        //            "description": description,
        "name": "Bench"
    ]
}

func createArray() -> [Routine] {
    var tempArrayForRoutines: [Routine] = []
    var tempArrayForExercises: [Exercise] = []
    
    let exercise = Exercise(dictionary: dictionary)
    tempArrayForExercises.append(exercise!)
    
    let routine1 = Routine(id: 1, name: "Morning routine", exercises: tempArrayForExercises)
    tempArrayForRoutines.append(routine1)
    
    
    
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
    
    // funkcia mi prida do pola Routines vsetky workouty ktore su priradene danemu userovi
    func loadUserRoutines(completion: @escaping () -> Void) {
        user = PFUser.current()
        if user != nil {
            // ziskam tabulku Workout
            let allWorkoutsForCurrentUserQuery = PFQuery(className:"Workout")
            
            // ziskam vsetky workouty ktore patria prihlasenemu userovi
            allWorkoutsForCurrentUserQuery.whereKey("user_id", equalTo: user!)
            allWorkoutsForCurrentUserQuery.findObjectsInBackground { (workouts, error) in
                if error == nil {
                    guard let returnedWorkouts = workouts else { return }
                        for workout in returnedWorkouts {
                            self.routines.append(workout)
                        }
                } else {
                    print(error?.localizedDescription)
                }
                completion()
            }
        } else {
            // Tu netreba pravdepodobne nic riesit, nakolko nemam anonymneho usera
        }
    }
    
    func loadExercisesInWorkout(routines: [PFObject], completion: () -> Void) -> String {
        let allExercisesInWorkout = PFQuery(className: "Exercise")
        allExercisesInWorkout.whereKey("workout", containedIn: routines)
        allExercisesInWorkout.findObjectsInBackground { (exercises, error) in
            if error == nil {
                guard let returnedExercises = exercises else { return }
                print(returnedExercises)
                for exercise in returnedExercises {
                    self.exercises.append(exercise)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
        return ""
    }
}





extension WorkoutsViewModel: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        loadUserRoutines {
            self.loadExercisesInWorkout(routines: self.routines,completion: {
                for routine in self.routines {
                    print(routine["name"])
                }
            })
        }
        
        
//        cell.setRoutineName(routineName: exercise.name)
//        cell.setExercisesLabel(exercises: exercise.exercises.description)
        
        return cell
    }
    
   


}
