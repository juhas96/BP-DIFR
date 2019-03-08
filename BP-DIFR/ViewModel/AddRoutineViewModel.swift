//
//  AddRoutineViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 01/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class AddRoutineViewModel: UIViewController {

    
    var collectionData: [Exercise] = []
    var exercisesId: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IDS: \(exercisesId)")
        // Do any additional setup after loading the view.
    }
    
    func showExercisesInWorkout() {
        print("Exercises: \(exercisesId)")
    }
    
    @IBAction func cancelAddingRoutine(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
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
//        return 0
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
