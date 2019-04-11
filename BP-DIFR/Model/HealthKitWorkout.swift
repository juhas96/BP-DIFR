//
//  HealthKitWorkout.swift
//  BP-DIFR
//
//  Created by jkbjhs on 11/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation


struct GymWorkoutInterval {
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    var totalEnergyBurned: Double {
        let prancerciseCaloriesPerHour: Double = 450
        let hours: Double = duration/3600
        let totalCalories = prancerciseCaloriesPerHour * hours
        return totalCalories
    }
}

struct GymWorkout {
    var start: Date
    var end: Date
    var intervals: [GymWorkoutInterval]
    
    init(with intervals: [GymWorkoutInterval]) {
        self.start = intervals.first!.start
        self.end = intervals.last!.end
        self.intervals = intervals
    }
    
    var totalEnergyBurned: Double {
        return intervals.reduce(0) { (result, interval) in
            result + interval.totalEnergyBurned
        }
    }
    
    var duration: TimeInterval {
        return intervals.reduce(0) { (result, interval) in
            result + interval.duration
        }
    }
}
