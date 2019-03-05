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

    // Break Timer
    @IBOutlet weak var breakTimerLabel: UILabel!
    
    // Label Workout Name
    @IBOutlet weak var workoutName: UILabel!
    
    // Label Timera
    @IBOutlet weak var timerLabel: UILabel!
    
    // Button addExercise
    @IBAction func addExerciseTapped(_ sender: Any) {
        // ak timer este nebol zapnuty tak ho zapnem, cize ak nebol vytvoreny objekt tak sa este nezapol, preto optional - nemusi byt vytvoreny na zaciatku
        if timer == nil {
            // zapnem timer s intervalom 1 sekunda
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
            
            // nastavim koniec timera podla seconds left
            // TODO: TOTO POJDE DO BREAK TIMERA
            endDate = Date().addingTimeInterval(secondsLeft)
            
            // updatnem UI
            updateTimerLabel()
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateTimerLabel()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - FUNKCIE UI
    
    // funkcia pre update hlavneho duration Timera
    func updateTimerLabel() {
        timerLabel.text = String(round(secondsLeft))
    }
    

    // MARK: - FUNKCIE TIMERU
    
    // zapnutie timeru
    func startTimer() {
        
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
    
    // vypnutie timeru
    func stopTimer() {
        
    }
    
    @objc func tickTimer() {
        // uberiem seconds left za kazdy tick
        secondsLeft -= 1
        
        // updatnem UI
        updateTimerLabel()
        
        // skontrolujem ci timer uz neskoncil
        if secondsLeft <= 0 {
            stopTimer()
        }
    }
    
    

}
