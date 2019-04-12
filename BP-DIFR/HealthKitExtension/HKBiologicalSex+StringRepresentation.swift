//
//  HKBiologicalSex+StringRepresentation.swift
//  BP-DIFR
//
//  Created by jkbjhs on 11/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import HealthKit

extension HKBiologicalSex {
    var stringRepresentation: String {
        switch self {
        case .notSet: return "Unknown"
        case .female: return "Female"
        case .male: return "Male"
        case .other: return "Other"
        }
    }
}
