//
//  ExerciseDetailViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 22/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var exerciseTitle: UINavigationBar!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var instructions: String = ""
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instructionsLabel.text = "This is simple instructions"
        exerciseImageView.image = image
        
        // Do any additional setup after loading the view.
    }
    
}
