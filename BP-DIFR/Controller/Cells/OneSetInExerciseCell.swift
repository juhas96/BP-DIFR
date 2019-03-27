//
//  OneSetInExerciseCell.swift
//  BP-DIFR
//
//  Created by jkbjhs on 03/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class OneSetInExerciseCell: UITableViewCell {

    @IBOutlet weak var setNumber: UILabel!
    @IBOutlet weak var previous: UILabel!
    @IBOutlet weak var kg: UITextField!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    
    let checkboxUnchecked = #imageLiteral(resourceName: "Checkmarkempty")
    let checkboxChecked = #imageLiteral(resourceName: "Checkmark")
    var buttonIsChecked = false
    
    @IBAction func checkButtonClicked(_ sender: Any) {
        print("CheckButton Clicked")
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
