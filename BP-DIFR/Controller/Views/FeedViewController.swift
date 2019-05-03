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
    
    var newsFeed = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeed.append(Feed(authorOfPost: "Jakub", postText: "Amazing push workout", timeOfPost: "a day ago", workoutDate: "2 May 2019", workoutDuration: "01:02:34", workoutKgLifted: "8400kg", workoutNumberOfExercises: "6"))
        newsFeed.append(Feed(authorOfPost: "Stanislav", postText: "Has a workout", timeOfPost: "a few days ago", workoutDate: "1 May 2019", workoutDuration: "0:52:12", workoutKgLifted: "12420kg", workoutNumberOfExercises: "8"))
        newsFeed.append(Feed(authorOfPost: "Miroslava", postText: "Legs Workout", timeOfPost: "a few days ago", workoutDate: "30 April 2019", workoutDuration: "0:42:25", workoutKgLifted: "4500kg", workoutNumberOfExercises: "4"))
        newsFeed.append(Feed(authorOfPost: "Jakub", postText: "Amazing push workout", timeOfPost: "a day ago", workoutDate: "2 May 2019", workoutDuration: "01:02:34", workoutKgLifted: "8400kg", workoutNumberOfExercises: "6"))
        newsFeed.append(Feed(authorOfPost: "Jakub", postText: "Amazing push workout", timeOfPost: "a day ago", workoutDate: "2 May 2019", workoutDuration: "01:02:34", workoutKgLifted: "8400kg", workoutNumberOfExercises: "6"))
        newsFeed.append(Feed(authorOfPost: "Jakub", postText: "Amazing push workout", timeOfPost: "a day ago", workoutDate: "2 May 2019", workoutDuration: "01:02:34", workoutKgLifted: "8400kg", workoutNumberOfExercises: "6"))
        newsFeed.append(Feed(authorOfPost: "Jakub", postText: "Amazing push workout", timeOfPost: "a day ago", workoutDate: "2 May 2019", workoutDuration: "01:02:34", workoutKgLifted: "8400kg", workoutNumberOfExercises: "6"))
        
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsFeedCell
        
        
        cell.authorOfPost.text = newsFeed[indexPath.row].authorOfPost
        cell.postText.text = newsFeed[indexPath.row].postText
        cell.timeOfPost.text = newsFeed[indexPath.row].timeOfPost
        cell.workoutDate.text = newsFeed[indexPath.row].workoutDate
        cell.workoutDuration.text = newsFeed[indexPath.row].workoutDuration
        cell.workoutKgLifted.text = newsFeed[indexPath.row].workoutKgLifted
        cell.workoutNumberOfExercises.text = newsFeed[indexPath.row].workoutNumberOfExercises
        
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

