//
//  ExerciseDetailViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 22/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseName: UINavigationItem!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseDescription: UILabel!
    
    var exercise: Exercise?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseDescription.sizeToFit()
        setUI()
    }
    
    func setUI() {
        exerciseDescription.text = exercise?.description
        exerciseName.title = exercise?.name
//        exerciseImage.image = exercise?.img_url
    }
    
}
