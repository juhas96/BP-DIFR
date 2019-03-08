//
//  ExercisesTableViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit


class ExercisesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images: [Image] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        FirebaseApp.configure()
        images = createArray()
        
    }
    
    
    
    func createArray() -> [Image] {
        var tempImage: [Image] = []
        
        let image1 = Image(image: UIImage(named: "exercise_image")!, title: "First exercise", category: "First Category")
        let image2 = Image(image: UIImage(named: "exercise_image")!, title: "Second exercise", category: "Second Category")
        let image3 = Image(image: UIImage(named: "exercise_image")!, title: "Third exercise", category: "Third Category")
        let image4 = Image(image: UIImage(named: "exercise_image")!, title: "Fourth exercise", category: "Fourth Category")
        let image5 = Image(image: UIImage(named: "exercise_image")!, title: "Fifth exercise", category: "Fifth Category")
        let image6 = Image(image: UIImage(named: "exercise_image")!, title: "Sixth exercise", category: "Sixth Category")
        
        tempImage.append(image1)
        tempImage.append(image2)
        tempImage.append(image3)
        tempImage.append(image4)
        tempImage.append(image5)
        tempImage.append(image6)
        
        return tempImage
    }
}



