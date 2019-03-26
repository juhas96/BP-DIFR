//
//  WorkoutViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 05/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Foundation

class WorkoutViewModel: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    // Break Timer
    @IBOutlet weak var breakTimerLabel: UILabel!
    
    // Label Workout Name
    @IBOutlet weak var workoutName: UILabel!
    
    var workoutNetworkService: WorkoutsNetworkService!
    
    var workoutsArray = [Workout]()
    
    
    // FINISH
    @IBAction func finishButtonTapped(_ sender: Any) {
        if timer != nil {
            timer?.invalidate()
        }
        
        if breakTimer != nil {
           breakTimer?.invalidate()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    // Label Timera
    @IBOutlet weak var timerLabel: UILabel!
    
    // Button addExercise
    @IBAction func addExerciseTapped(_ sender: Any) {
        
    }
    
    // Button cancelWorkout
    @IBAction func cancelWorkoutTapped(_ sender: Any) {
    }
    
    // Timer - duration of Workout
    var timer: Timer?
    
    // koniec timera
    var endDate: Date!
    
    // Timer - break between sets Timer 
    var breakTimer: Timer?
    
    var secondsLeft: TimeInterval = 100
    
    var counter = 0.0
    
    
    
    var exercisesSetsArray = [ExercisesSet]()
    var setsArray = [[ExercisesSet]]()
    
    var groupedDict = [String? : [ExercisesSet]]()
    var groupedSets = [[ExercisesSet]]()
    var keys: Dictionary<String?, [ExercisesSet]>.Keys!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutNetworkService = WorkoutsNetworkService()
        workoutNetworkService.getAllWorkouts { (workouts) in
            DispatchQueue.main.async {
                if let workouts = workouts {
                    // Ziskam vsetky workouty
                    self.workoutsArray = workouts
                    self.tableView.reloadData()
                    
                    // Ziskam vsetky Sety z Workoutu
                    self.exercisesSetsArray = self.workoutsArray[0].exercisesSets
                    
                    // Vyfiltrujem ich podla Exercise ktore obsahuju, tym padom dostanem Key : Value kde Key je Exercise a Value je Exercise_Set
                    self.groupedDict = Dictionary(grouping: self.exercisesSetsArray, by: { (exerciseSet) -> String? in
                        return exerciseSet.exercise?.name
                    })
                    
                    // Zoberiem kluce z dictionary
                    self.keys = self.groupedDict.keys
                    
                    // Unikatne naplnim 2d pole s exerciseSets
                    // tym padom viem vytvorit sekcie s Exercise a ExerciseSet ktore su spolu groupnute
                    self.keys.forEach({ (key) in
                        self.groupedSets.append(self.groupedDict[key]!)
                    })
                    
                    self.tableView.reloadData()
                }
            }
        }
        
        self.tableView.reloadData()
        
        
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runWorkoutDurationTimer), userInfo: nil, repeats: true)
        }
        
        updateBreakTimerLabel()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - FUNKCIE UI
    
    // funkcia pre update hlavneho duration Timera
    func updateBreakTimerLabel() {
        breakTimerLabel.text = String(round(secondsLeft))
    }
    

    // MARK: - FUNKCIE TIMERU
    
    // zapnutie timeru
    @objc func startTimer() {
        
//        // ak timer este nebol zapnuty tak ho zapnem, cize ak nebol vytvoreny objekt tak sa este nezapol, preto optional - nemusi byt vytvoreny na zaciatku
//        if timer == nil {
//            // zapnem timer s intervalom 1 sekunda
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
//
//            // nastavim koniec timera podla seconds left
//            // TODO: TOTO POJDE DO BREAK TIMERA
//            endDate = Date().addingTimeInterval(secondsLeft)
//
//            // updatnem UI
//            updateTimerLabel()
//        }
        
        
        
    }
    
    @objc func runWorkoutDurationTimer() {
        counter += 0.1
        
        // FORMAT HH:MM:SS
        // Prekonvertujem si label na user friendly zobrazenie casu
        
        // zaokruhlim si counter
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter / 3600
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        
        timerLabel.text = "\(hour):\(minuteString):\(secondString).\(decisecond)"

    }
    
    // vypnutie timeru
    func stopTimer() {
        
    
    }
    
    @objc func tickTimer() {
        // uberiem seconds left za kazdy tick
        secondsLeft -= 1
        
        // updatnem UI
        updateBreakTimerLabel()
        
        // skontrolujem ci timer uz neskoncil
        if secondsLeft <= 0 {
            stopTimer()
        }
    }
    
    

}

extension WorkoutViewModel: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedSets[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedSets.count
    }

    // TODO: Dorobit Cell unikatnu, REPS,KG,Fajka, PREV
    // TODO: Skusit tahat PREV Z DB
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        let name = groupedSets[indexPath.section][indexPath.row].reps
        return cell

    }
    
    // Nastavujem header pre sekciu
    // TODO: nastavit header podla nazvu cviku
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Exercise"
        label.backgroundColor = UIColor.blue
        return label
    }



}

//
//timer
//
//// ak timer este nebol zapnuty tak ho zapnem, cize ak nebol vytvoreny objekt tak sa este nezapol, preto optional - nemusi byt vytvoreny na zaciatku
//if breakTimer == nil {
//    // zapnem timer s intervalom 1 sekunda
//    breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
//    
//    // nastavim koniec timera podla seconds left
//    // TODO: TOTO POJDE DO BREAK TIMERA
//    endDate = Date().addingTimeInterval(secondsLeft)
//    
//    // updatnem UI
//    updateBreakTimerLabel()
//}
