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

// MARK: - Dummy Simulator Data
//extension HKManager {
//    var mockSamples: [HKQuantitySample] {
//        var result = [HKQuantitySample]()
//        
//        for i in 0 ..< 28 {
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)!
//            
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount),
//                                              quantity: HKQuantity(unit: .count(), doubleValue: .random(in: 4_000 ... 20_000)),
//                                              start: startDate,
//                                              end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass),
//                                                quantity: HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3)))),
//                                                start: startDate,
//                                                end: endDate)
//            
//            result.append(stepSample)
//            result.append(weightSample)
//        }
//        
//        return result
//    }
//    
//    func addSimData() async {
//        try! await store.save(mockSamples)
//    }
//}
