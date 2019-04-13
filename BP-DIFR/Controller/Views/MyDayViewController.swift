//
//  MyDayViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import SwiftCharts

class MyDayViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weeks: [String]!
    var chartView: BarsChart!
    
    var workouts = [Workout]()
    var workoutService: WorkoutsNetworkService!
    var bars = [(String, Double)]()
    var user: AppUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = ProfileHelper()
        profile.fetchUsers { (appUser) in
            if appUser != nil {
                self.user = appUser
                self.workoutService = WorkoutsNetworkService()
                self.workoutService.getWorkoutsByUser(userUid: self.user.uid) { (workouts) in
                    DispatchQueue.main.async {
                        if let workouts = workouts {
                            self.workouts = workouts
                            self.collectionView.reloadData()
                        }
                    }
                }
                self.setUpChart()
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    func setUpChart() {
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 7, by: 1))
        let frame = CGRect(x: 0, y: 150, width: self.view.frame.width - 30, height: 150)
        self.bars.append(("1",4.0))
        self.bars.append(("2",5.0))
        self.bars.append(("3",2.0))
        self.bars.append(("4",1.0))
        self.bars.append(("5",1.0))
        self.bars.append(("6",1.0))
        self.bars.append(("7",1.0))
        self.bars.append(("8",1.0))
        let chart = BarsChart(frame: frame,
                              chartConfig: chartConfig,
                              xTitle: "Weeks",
                              yTitle: "Workouts Performed",
                              bars: self.bars,
                              color: UIColor.blue,
                              barWidth: 15)
        
        self.view.addSubview(chart.view)
        self.chartView = chart
    }
        
}

// MARK: Collection View
extension MyDayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyWorkoutCell", for: indexPath) as! HistoryWorkoutCollectionViewCell
        
        var workout: Workout!
        
        if (workouts.count != 0 ) {
            workout = workouts[indexPath.row]
        }
        
        let exercises = workout.exercisesSets.count
        
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
        
        cell.setExercises(exercises: String(exercises))
        cell.setDuration(duration: String(workout.duration))
        cell.setLiftedKg(liftedKg: String(workout.kgLiftedOverall))
        cell.setWorkoutName(workoutName: workout.name)
        cell.setWorkoutDate(workoutDate: workout.startDate)
        
        
        return cell
    }
}

