//
//  ExercisesViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 24/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse

// Struktura pre JSON Api ktore dotiahnem
// Ja pracuje muz len s results kde sa nachadzaju cviky
//struct WholeJsonModel: Decodable {
//    let count: Int?
//    let next: String?
//    let previous: String?
//    let results: [ExerciseApiModel]
//}

class ExercisesViewModel: UIViewController {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    
    var exerciseArray = [Exercise]()
    var localExercises = [PFObject]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.exercisesTableView.reloadData()
    }
    
    
    func loadData() {
        let query = PFQuery(className: "Exercise")
        query.findObjectsInBackground { (exercise, error) in
            if error == nil {
                if let returnedExercises = exercise{
                    self.localExercises = returnedExercises
                    self.exercisesTableView.reloadData()
                }
            } else {
                print("ERROR WHILE QUERY: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        exercisesTableView.reloadData()
        
    }
    
    
    
    
    
}



extension ExercisesViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localExercises.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        if (localExercises.count != 0) {
            let exercise:PFObject = localExercises[indexPath.row]
            cell.setLabel(label: exercise.object(forKey: "name") as! String)
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
    }
    
}
