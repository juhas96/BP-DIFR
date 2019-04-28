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
    
    @IBAction func toProgressView(_ sender: Any) {
        performSegue(withIdentifier: "toProgress", sender: exercise?.id)
    }
    var exercise: Exercise?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseDescription.sizeToFit()
        setUI()
    }
    
    func setUI() {
        exerciseDescription.text = exercise?.description
        exerciseName.title = exercise?.name
        if exercise?.imgURL != nil {
            ImageService.getImage(withURL: URL(string: exercise?.imgURL as! String)!) { (image) in
                self.exerciseImage.image = image
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProgress" {
            let vc = segue.destination as! ProgressViewController
            vc.exerciseId = sender as? Int
        }
    }
    
}
