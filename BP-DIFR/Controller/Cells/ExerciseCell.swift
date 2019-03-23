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
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    func setLabel(label: String) {
        self.exerciseNameLabel.text = label
    }
    
    func setImageView(image: UIImage) {
        self.exerciseImageView.image = image
    }
}
