//
//  AddRoutineViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 01/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse

struct ExampleWorkout {
    let name: String
    let exercises: String
    
}

class AddRoutineViewModel: UIViewController {
    
    var workout = [ExampleWorkout]()
    
    var collectionData: [PFObject] = []
    var exercisesId: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IDS: \(exercisesId)")
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func showExercisesInWorkout() {
        print("Exercises: \(exercisesId)")
    }
    
    @IBAction func cancelAddingRoutine(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    func loadData() {
        let query = PFQuery(className: "Exercise")
        query.whereKey("objectId", containedIn: exercisesId)
        query.findObjectsInBackground { (exercise, error) in
            if error == nil && exercise != nil {
                self.collectionData = exercise!
            }
        }
    }
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension AddRoutineViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return workout.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCollectionCell", for: indexPath)
//        
//        
//        
//        return cell
//    }
//}
