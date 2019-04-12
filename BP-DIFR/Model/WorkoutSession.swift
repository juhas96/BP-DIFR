//  Created by jkbjhs on 07/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import HealthKit

enum WorkoutSessionState {
    case notStarted
    case active
    case finished
}

class WorkoutSession {
    private (set) var startDate: Date!
    private (set) var endDate: Date!
    
    var intervals: [GymWorkoutInterval] = []
    var state: WorkoutSessionState = .notStarted
    
    func start() {
        startDate = Date()
        state = .active
    }
    
    func end() {
        endDate = Date()
        addNewInterval()
        state = .finished
    }
    
    func clear() {
        startDate = nil
        endDate = nil
        state = .notStarted
        intervals.removeAll()
    }
    
    private func addNewInterval() {
        let interval = GymWorkoutInterval(start: startDate,
                                                  end: endDate)
        intervals.append(interval)
    }
    
    var completeWorkout: GymWorkout? {
        guard state == .finished, intervals.count > 0 else {
            return nil
        }
        
        return GymWorkout(with: intervals)
    }
}
