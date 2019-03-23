//
//  CreateExerciseViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CreateExerciseViewModel: UIViewController {
    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var exerciseDescriptionTextField: UITextField!
    
    var exerciseNetworkService = ExercisesNetworkService()
    var exercise = Parameters()
    
    @IBAction func addButtonTapped(_ sender: Any) {
        addExerciseToDatabase()
        self.dismiss(animated: true, completion: nil)
    }
    
    func addExerciseToDatabase() {
        exercise =
        [
            "name":             exerciseNameTextField.text!,
            "description":      exerciseDescriptionTextField.text!
        
        ]
        print(exercise)
        exerciseNetworkService.createExercise(exercise: exercise)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
