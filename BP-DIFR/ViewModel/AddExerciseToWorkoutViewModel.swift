//
//  AddExerciseToWorkoutViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 08/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit


class AddExerciseToWorkoutViewModel: UIViewController {

    
    @IBOutlet weak var exercisesTableView: UITableView!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var exerciseArray = [Exercise]()
    var exerciseSearchArray = [Exercise]()
    var exerciseSetsArray = [ExercisesSet]()
    var exerciseService: ExercisesNetworkService!
    var searchController: UISearchController!
    var exerciseSet: ExercisesSet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        exerciseService = ExercisesNetworkService()
        exerciseService.getAllExercises { (exercises) in
            DispatchQueue.main.async {
                if let exercises = exercises {
                    self.exerciseArray = exercises
                    self.exerciseSearchArray = self.exerciseArray
                    self.exercisesTableView.reloadData()
                }
            }
        }
        self.exercisesTableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        exerciseSearchArray = exerciseArray.filter({(exercise : Exercise) -> Bool in
            return exercise.name!.lowercased().contains(searchText.lowercased())
        })
        exercisesTableView.reloadData()
    }
    
    func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Hľadať cviky"
            navigationItem.searchController = searchController
            definesPresentationContext = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func createSetsFromExercise(indexPath: Int) {
        let exercise = exerciseArray[indexPath]
        exerciseSet = ExercisesSet()
        exerciseSet.exercise = exercise
        exerciseSet.kg = 0
        exerciseSet.reps = 0
//        exerciseSet.id = 0
    }
    
}


// MARK: TableView
extension AddExerciseToWorkoutViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        if (exerciseArray.count != 0) {
            let exercise = exerciseArray[indexPath.row]
            cell.setLabel(label: exercise.name!)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createSetsFromExercise(indexPath: indexPath.row)
        NotificationCenter.default.post(name: .addExerciseToWorkout, object: exerciseSet)
        let alert = UIAlertController(title: "Exercises Added", message: "New exercise added to current workout!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

// MARK: SEARCH BAR
extension AddExerciseToWorkoutViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

// MARK: Notifikacia na poslanie Exercisu do aktualneho workoutu
// MARK: Notifikacia pre observer
extension Notification.Name {
    static let addExerciseToWorkout = Notification.Name(rawValue: "AddExerciseToWorkout")
}

