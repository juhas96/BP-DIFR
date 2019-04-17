//
//  ExercisesViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 24/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseAuth
import CoreML
import Vision

class ExercisesViewModel: UIViewController {
    
    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker,animated: true, completion: nil)
    }
    
    @IBOutlet weak var exercisesTableView: UITableView!
    
    let imagePicker = UIImagePickerController()
    
    // Pole vsetkych cvikov
    var exercisesArray = [Exercise]()
    
    // service
    var exerciseService: ExercisesNetworkService!
    
    // Filtrovane pole cvikov
    var exerciseSearchArray = [Exercise]()
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser)
        } else {
            print("current user is nil")
        }
        
        let calendar = Calendar.current
        let weekOfYear = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        print("CurrentWeek: \(weekOfYear)")
        
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        
        self.exercisesTableView.reloadData()
        exerciseService = ExercisesNetworkService()
        exerciseService.getAllExercises { (exercises) in
            DispatchQueue.main.async {
                if let exercises = exercises {
                    self.exercisesArray = exercises
                    self.exerciseSearchArray = self.exercisesArray
                    self.exercisesTableView.reloadData()
                }
            }
            self.exercisesTableView.reloadData()
        }
        
        
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
    
    // zistim si ci je search bar prazdny
    func searchBarIsEmpty() -> Bool {
        // vraciam TRUE ak je prazdny alebo je nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        exerciseSearchArray = exercisesArray.filter({(exercise : Exercise) -> Bool in
            return exercise.name!.lowercased().contains(searchText.lowercased())
        })
        exercisesTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        exercisesTableView.reloadData()
    }
}

extension ExercisesViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return exerciseSearchArray.count
        }
        return exercisesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        let exercise: Exercise
        
        if (exerciseSearchArray.count != 0) {
            if isFiltering() {
                exercise = exerciseSearchArray[indexPath.row]
            } else {
                exercise = exercisesArray[indexPath.row]
            }
            cell.setLabel(label: (exercise.name!))
            cell.setImageView(exerciseUrl: exercise.imgURL)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showExerciseSegue" {
            let vc = segue.destination as! ExerciseDetailViewController
            vc.exercise = sender as? Exercise
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exerciseSearchArray[indexPath.row]
        performSegue(withIdentifier: "showExerciseSegue", sender: exercise)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let id = exercisesArray[indexPath.row].id
            exerciseService.removeExercise(exerciseId: id)
            exercisesArray.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension ExercisesViewModel: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


// MARK: MLKit - Image Recognition
extension ExercisesViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else { fatalError("Could not convert to CIImage.")}
            
            detect(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else { fatalError("Loading CoreML Model Failed.") }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let results = request.results as? [VNClassificationObservation] else { fatalError("Model failed to process image.") }
                
                if let firstResult = results.first {
                    self.navigationItem.title = firstResult.identifier
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
