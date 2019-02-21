//
//  ExerciseCell.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    // MARK: - OUTLETS
    @IBOutlet weak var ExerciseCategoryLabel: UILabel!
    @IBOutlet weak var ExerciseNameLabel: UILabel!
    @IBOutlet weak var ExerciseImageView: UIImageView!
    
    func setImage(image: Image) {
        ExerciseImageView.image = image.image
        ExerciseNameLabel.text = image.title
        ExerciseCategoryLabel.text = image.category
    }
}
