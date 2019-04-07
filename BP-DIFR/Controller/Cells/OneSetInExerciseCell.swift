//
//  OneSetInExerciseCell.swift
//  BP-DIFR
//
//  Created by jkbjhs on 03/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

protocol OneSetInExerciseCellDelegate {
    func didTapCheckButton(kg: String, reps: String, index: IndexPath)
}

class OneSetInExerciseCell: UITableViewCell {

    @IBOutlet weak var setNumber: UILabel!
    @IBOutlet weak var previous: UILabel!
    @IBOutlet weak var kg: UITextField!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    var exerciseSet: ExercisesSet!
    var delegate: OneSetInExerciseCellDelegate?
    
    var indexPath: IndexPath!
    
    func setExerciseSet(exerciseSet: ExercisesSet) {
        self.exerciseSet = exerciseSet
    }
    
    let checkboxUnchecked = #imageLiteral(resourceName: "Checkmarkempty")
    let checkboxChecked = #imageLiteral(resourceName: "Checkmark")
    var buttonIsChecked = false
    
    @IBAction func checkButtonClicked(_ sender: Any) {
        delegate?.didTapCheckButton(kg: kg.text!, reps: reps.text!, index: indexPath)
        
        if !buttonIsChecked {
            checkButtonOutlet.setImage(checkboxChecked, for: .normal)
            buttonIsChecked = true
        } else if buttonIsChecked {
            checkButtonOutlet.setImage(checkboxUnchecked, for: .normal)
            buttonIsChecked = false
        }
        
        
        
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
