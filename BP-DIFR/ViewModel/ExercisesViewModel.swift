//
//  ExercisesViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 24/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import Parse
=======
import FirebaseFirestore
import Firebase
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises

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
    
    var db: Firestore!
    
    var exerciseArray = [Exercise]()
    var localExercises = [PFObject]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        loadData()
        self.exercisesTableView.reloadData()
=======
//        FirebaseApp.configure()
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        loadData()
    
        
//        addDataToFirestore()
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
    }
    
    
    func loadData() {
<<<<<<< HEAD
        let query = PFQuery(className: "Exercise")
        query.findObjectsInBackground { (exercise, error) in
            if error == nil {
                if let returnedExercises = exercise{
                    self.localExercises = returnedExercises
                    self.exercisesTableView.reloadData()
                }
            } else {
                print("ERROR WHILE QUERY: \(String(describing: error?.localizedDescription))")
=======
        db.collection("exercises").getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.exerciseArray = snapshot!.documents.compactMap({Exercise(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.exercisesTableView.reloadData()
                }
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
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
<<<<<<< HEAD
//        print("SELECTED ROW: \(indexPath.row)")
//        let exercise = exerciseArray[indexPath.row]
//        print("Exercise name: \(exercise.name)")
//        print("Exercise id: \(exercise.id)")
//        print("EXERCISE category: \(exercise.category)")
//        print("EXERCISE category: \(exercise.description)")
=======
        print("SELECTED ROW: \(indexPath.row)")
        let exercise = exerciseArray[indexPath.row]
        print("Exercise name: \(exercise.name)")
        print("Exercise id: \(exercise.id)")
//        print("Exercise: \(exercise.dictionary[])")
>>>>>>> parent of d6e5e6a... oprava IDcok pri Exercises
    }
    
}
