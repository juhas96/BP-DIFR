//
//  FeedViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 27/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

let cellId = "feedCell"

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsFeedCell
        
        
        cell.authorOfPost.text = "Jakub"
        cell.postText.text = "Has a workout"
        cell.timeOfPost.text = "an hour ago"
        cell.workoutDate.text = "27 March 2019"
        cell.workoutDuration.text = "00:33:00"
        cell.workoutKgLifted.text = "1200kg"
        cell.workoutNumberOfExercises.text = "12"
        
        // styling cell
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
        
    }

    
    
}

