//
//  HKManager.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/23/24.
//

import Foundation
import HealthKit
import Observation

@Observable 
class HKManager {
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
