//
//  WorkoutsViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse

class WorkoutsViewModel: UIViewController {    
    
    @IBOutlet weak var tableView: UITableView!
    
    var routines = [PFObject]()
    var exercises = [PFObject]()
    var user: PFUser?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}





extension WorkoutsViewModel: UITableViewDelegate, UITableViewDataSource {
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        
        if(routines.count != 0) {
            let routine:PFObject = routines[indexPath.row]
            cell.setRoutineName(routineName: routine.object(forKey: "name") as! String)
            var exerciseString = ""
            for exercise in exercises {
                if let singleExercise:PFObject = exercise {
                    exerciseString.append(singleExercise.object(forKey: "name") as! String)
                    exerciseString.append(", ")
                }
            }
            cell.setExercisesLabel(exercises: exerciseString)
        }

        
        return cell
    }
    
    func loadData() {
        user = PFUser.current()
        if user != nil {
            // ziskam tabulku Workout
            let allWorkoutsForCurrentUserQuery = PFQuery(className: "Workout")
            
            // vyfiltrujem si workouty podla usera
            allWorkoutsForCurrentUserQuery.whereKey("user_id", equalTo: user!)
            allWorkoutsForCurrentUserQuery.findObjectsInBackground { (workouts, error) in
                if error == nil {
                    // ak existuju workouty vlozim si ich ku sebe, inak skonci funkcia
                    guard let returnedWorkouts = workouts else { return }
                    self.routines = returnedWorkouts
                    
                    // ziskam tabulku Exercise
                    let allExercisesInWorkoutQuery = PFQuery(className: "Exercise")
                    
                    // vyfiltrujem cviky ktore patria workoutu
                    allExercisesInWorkoutQuery.whereKey("workout", containedIn: returnedWorkouts)
                    allExercisesInWorkoutQuery.findObjectsInBackground(block: { (exercises, error) in
                        if error == nil {
                            // ak existuju vlozim si ich ku sebe
                            guard let returnedExercises = exercises else { return }
                            self.exercises = returnedExercises
                            // reloadnem tableView aby sa zobrazili data
                            self.tableView.reloadData()
                        } else {
                            print(error?.localizedDescription ?? "Error while loading exercises")
                        }
                    })
                } else {
                    print(error?.localizedDescription ?? "Error while loading workouts")
                }
            }
        }
    }
    
   


}
