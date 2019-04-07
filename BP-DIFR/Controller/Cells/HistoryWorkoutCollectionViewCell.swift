//
//  HistoryWorkoutCollectionViewCell.swift
//  BP-DIFR
//
//  Created by jkbjhs on 06/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class HistoryWorkoutCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var workoutName: UILabel!
    
    @IBOutlet weak var workoutDate: UILabel!
    
    @IBOutlet weak var liftedKg: UILabel!
    
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var exercises: UILabel!
    
    
    func setWorkoutName(workoutName: String) {
        self.workoutName?.text = workoutName
    }
    
    func setWorkoutDate(workoutDate: String) {
        self.workoutDate?.text = workoutDate
    }
    
    func setLiftedKg(liftedKg: String) {
        self.liftedKg?.text = liftedKg
    }
    
    func setDuration(duration: String) {
        self.duration?.text = duration
    }
    
    func setExercises(exercises: String) {
        self.exercises?.text = exercises
    }
    
}
