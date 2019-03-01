//
//  WorkoutsViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import LNPopupController

class WorkoutsViewModel: UIViewController {

    
    var routines: [Routine] = []
    var exercises: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routines = createArray()
    }


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
    
    
    
    
    
    return tempArrayForRoutines
}



extension WorkoutsViewModel: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutCell
        let exercise = routines[indexPath.row]
        
        cell.setRoutineName(routineName: exercise.name)
//        cell.setExercisesLabel(exercises: exercise.exercises.description)
        
        return cell
    }


}
