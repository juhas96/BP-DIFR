//
//  HKBloodType+StringRepresentation.swift
//  BP-DIFR
//
//  Created by jkbjhs on 11/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import HealthKit

extension HKBloodType {
    var stringRepresentation: String {
        switch self {
        case .notSet: return "Unknown"
        case .aPositive: return "A+"
        case .aNegative: return "A-"
        case .bPositive: return "B+"
        case .bNegative: return "B-"
        case .abPositive: return "AB+"
        case .abNegative: return "AB-"
        case .oPositive: return "O+"
        case .oNegative: return "O-"
        }
    }
}
