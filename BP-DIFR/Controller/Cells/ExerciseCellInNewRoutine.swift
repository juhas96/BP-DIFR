//
//  ExerciseCellInNewRoutine.swift
//  BP-DIFR
//
//  Created by jkbjhs on 03/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class ExerciseCellInNewRoutine: UITableViewCell {
    
    
    @IBOutlet weak var exerciseName: UILabel!
    
    func setExerciseName(exerciseName: String) {
        self.exerciseName.text = exerciseName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
