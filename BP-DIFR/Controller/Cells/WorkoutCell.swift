//
//  WorkoutCell.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {

    
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var exercisesLabel: UILabel!
    
    func setRoutineName(routineName: String) {
        self.routineName.text = routineName
    }
    
    func setExercisesLabel(exercises: String){
        self.exercisesLabel.text = exercises
    }
    
}
