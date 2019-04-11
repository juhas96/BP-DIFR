//
//  UserHealthProfile.swift
//  BP-DIFR
//
//  Created by jkbjhs on 11/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import HealthKit

class UserHealthProfile {
    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?
    var heightInMeters: Double?
    var weightInKilograms: Double?
    
    var bodyMassIndex: Double? {
        guard
            let weightInKilograms = weightInKilograms,
            let heightInMeters = heightInMeters,
            heightInMeters > 0
            else {
                return nil
        }
        
        return (weightInKilograms/(heightInMeters*heightInMeters))
    }
}
