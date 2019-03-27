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

    
    // TODO: Upratat triedu
    
    @IBOutlet weak var tableView: UITableView!
    // Break Timer
    @IBOutlet weak var breakTimerLabel: UILabel!
    
    // Label Workout Name
    @IBOutlet weak var workoutName: UILabel!
    
    // Kliknutie na checkButton - zapnem break timer
    @IBAction func checkButtonClicked(_ sender: Any) {
        createBreakTimer()
    }
    
    var workoutNetworkService: WorkoutsNetworkService!
    
    var workoutsArray = [Workout]()
    
    var currentWorkout: Workout!
    
    var numberOfRowsInSection: Int!
    
    
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
    
    var secondsLeft: TimeInterval = 10
    
    var counter = 0.0
    
    
    
    var exercisesSetsArray = [ExercisesSet]()
    var setsArray = [[ExercisesSet]]()
    
    var groupedDict = [String? : [ExercisesSet]]()
    var groupedSets = [[ExercisesSet]]()
    var keys: Dictionary<String?, [ExercisesSet]>.Keys!
    
    
    func addSetToArrayAndToTableView() {
        var exerciseSet = ExercisesSet()
        exerciseSet.exercise = groupedSets[0][0].exercise
        exerciseSet.kg = 0
        exerciseSet.reps = 0
        groupedSets[0].append(exerciseSet)
        print(groupedSets.count)
    }
    
    @IBAction func addSetButtonTapped(_ sender: UIButton) {
        addSetToArrayAndToTableView()
    }
    
    
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
        
        
        
        createTimer()
        
        // pridam observer na prijatie + - sekund z ineho View
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimer(notification:)), name: .timerUpdated, object: nil)
    }
}

// MARK: TableView
extension WorkoutViewModel: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groupedSets[section].count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedSets.count
    }

    // TODO: Dorobit Cell unikatnu, REPS,KG,Fajka, PREV
    // TODO: Skusit tahat PREV Z DB
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "staticExerciseCell") else { return UITableViewCell() }
            return cell
        } else if indexPath.row == totalRows - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addSetCell") else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "oneSetCell") as? OneSetInExerciseCell else { return UITableViewCell() }
            cell.setNumber.text = String(indexPath.row)
            return cell
        }
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

// MARK: Timer
extension WorkoutViewModel {
    
    func createTimer() {
        if timer == nil {
            // Nastavim timer na sekundovy interval
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(runWorkoutDurationTimer), userInfo: nil, repeats: true)
            
            // zabranuje stopovaniu timera pri pouzivani UI
            RunLoop.current.add(timer!, forMode: .common)
            
            // Energy efficience
            timer!.tolerance = 0.1
        }
    }
    
    @objc func runWorkoutDurationTimer() {
        counter += 1
        
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
        
        timerLabel.text = "\(hour):\(minuteString):\(secondString)"
    }
}


// MARK: BreakTimer
extension WorkoutViewModel {
    
    // MARK: - FUNKCIE UI
    
    // funkcia pre update hlavneho duration Timera
    func updateBreakTimerLabel() {
        breakTimerLabel.text = String("\(round(secondsLeft))s")
    }
    
    // vypnutie break timeru
    func stopBreakTimer() {
        if breakTimer != nil {
            print("som vynuloval")
            breakTimer?.invalidate()
            breakTimer = nil
        }
    }
    
    @objc func breakTimerTick() {
        // uberiem seconds left za kazdy tick
        if secondsLeft > 0 {
            secondsLeft -= 1
        }
        
        print("Som sa zavolal")
        NotificationCenter.default.post(name: .timer, object: secondsLeft)
        
        // updatnem UI
        updateBreakTimerLabel()
        
        // skontrolujem ci timer uz neskoncil
        if secondsLeft <= 0 {
            stopBreakTimer()
        }
    }
    
    func createBreakTimer() {
        secondsLeft = 10
        updateBreakTimerLabel()
        if breakTimer == nil {
            // zapnem timer s intervalom 1 sekunda
            breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(breakTimerTick), userInfo: nil, repeats: true)

            
            // nastavim koniec timera podla seconds left
            // TODO: TOTO POJDE DO BREAK TIMERA
            endDate = Date().addingTimeInterval(secondsLeft)
            
            // updatnem UI
            updateBreakTimerLabel()
        }
    }
    
    // Nastavi zbyvajuci cas na break ak som v druhom View pridal / ubral sekundy
    @objc func updateTimer(notification: Notification) {
        self.secondsLeft = notification.object as! TimeInterval
    }
}


// MARK: Notifikacia pre observer
extension Notification.Name {
    static let timer = Notification.Name(rawValue: "Timer")
}
