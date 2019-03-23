//
//  WorkoutViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 05/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Foundation
import Parse

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class WorkoutViewModel: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    // Break Timer
    @IBOutlet weak var breakTimerLabel: UILabel!
    
    // Label Workout Name
    @IBOutlet weak var workoutName: UILabel!
    
    var workouts = [Workout]()
    var tableViewData = [cellData(opened: false, title: "Prvy trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
                         cellData(opened: false, title: "Druhy trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
                         cellData(opened: false, title: "Tretia trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
                         cellData(opened: false, title: "Stvrtok trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"])]
//
//    tableViewData = [cellData(opened: false, title: "Prvy trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
//    cellData(opened: false, title: "Druhy trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
//    cellData(opened: false, title: "Tretia trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"]),
//    cellData(opened: false, title: "Stvrtok trening", sectionData: ["Cvik1","Cvik2","Cvik3","Cvik4"])]
    
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
        // ak timer este nebol zapnuty tak ho zapnem, cize ak nebol vytvoreny objekt tak sa este nezapol, preto optional - nemusi byt vytvoreny na zaciatku
        if breakTimer == nil {
            // zapnem timer s intervalom 1 sekunda
            breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
            
            // nastavim koniec timera podla seconds left
            // TODO: TOTO POJDE DO BREAK TIMERA
            endDate = Date().addingTimeInterval(secondsLeft)
            
            // updatnem UI
            updateBreakTimerLabel()
        }
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "testCell") else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none )
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none )
            }
        }
}
    
    
    
    
    
    
    
    
    
}
