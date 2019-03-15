//
//  AddExerciseToWorkoutViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 08/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse

class AddExerciseToWorkoutViewModel: UIViewController {

    @IBOutlet weak var exercisesTableView: UITableView!
    @IBAction func addExercisesButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddRoutineViewModel
        vc.exercisesId = self.idArray
    }
    
    // pole IDcok do ktoreho pridam idcko cviku z DB po tapnuti na dany row v table view, nasledne pole posielam s5 do view s workoutom kde podla toho vytvorim dane cell
    var idArray: [String] = []
    
    // Reloadnutie table view
    @IBAction func reloadDataTapped(_ sender: Any) {
        self.exercisesTableView.reloadData()
    }
    
    var exerciseArray = [Exercise]()
    var localExercises = [PFObject]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        
    }
    
    
//    func loadData() {
//        let query = PFQuery(className: "Exercise")
//        query.findObjectsInBackground { (exercise, error) in
//            if error == nil {
//                if let returnedExercises = exercise {
//                    for exercise in returnedExercises {
//                        self.exerciseArray.append(Exercise(category: exercise["category"] as! Int, description: exercise["description"] as! String, name: exercise["name"] as! String, id: exercise.objectId!))
//                    }
//                }
//                PFObject.pinAll(inBackground: self.localExercises)
//            } else {
//                print("ERROR WHILE QUERY: \(String(describing: error?.localizedDescription))")
//            }
//        }
//    }
    
}



extension AddExerciseToWorkoutViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        if (exerciseArray.count != 0) {
            let exercise = exerciseArray[indexPath.row]
            cell.setLabel(label: exercise.name)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("SELECTED ROW: \(indexPath.row)")
//        let exercise = exerciseArray[indexPath.row]
//        print("Exercise name: \(exercise.name)")
//        print("Exercise id: \(exercise.id)")
//        print("EXERCISE category: \(exercise.category)")
//        print("EXERCISE category: \(exercise.description)")
//        self.idArray.append(exercise.id)
    }

}
