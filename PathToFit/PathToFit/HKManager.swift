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
    
    var stepData: [HealthMetric] = []
    var weightData: [HealthMetric] = []
    
    private func fetchHKData(_ metric: HealthMetricContext) async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(metric.quantityTypeId), predicate: queryPredicate)
        
        let query = HKStatisticsCollectionQueryDescriptor(predicate: samplePredicate,
                                                          options: metric.statsOption,
                                                          anchorDate: endDate,
                                                          intervalComponents: .init(day: 1))
        
        let statsCollection = try! await query.result(for: store)
        let metricData = metric.generateHealthMetrics(from: statsCollection)

        switch metric {
        case .steps:
            stepData = metricData
        case .weight:
            weightData = metricData
        }
    }
    
    func fetchStepCount() async {
        await fetchHKData(.steps)
    }
    
    func fetchWeights() async {
        await fetchHKData(.weight)
    }
}

// MARK: - Internal Metric Context
private extension HealthMetricContext {
    var statsOption: HKStatisticsOptions {
        switch self {
        case .steps:
            return .cumulativeSum
        case .weight:
            return .mostRecent
        }
    }
    
    var quantityTypeId: HKQuantityTypeIdentifier {
        switch self {
        case .steps:
            return .stepCount
        case .weight:
            return .bodyMass
        }
    }
    
    func generateHealthMetrics(from stats: HKStatisticsCollection) -> [HealthMetric] {
        return stats.statistics().map { stat in
                .init(date: stat.startDate, value: getMetricValue(from: stat))
        }
    }
    
    private func getMetricValue(from stat: HKStatistics) -> Double {
        switch self {
        case .steps:
            return stat.sumQuantity()?.doubleValue(for: .count()) ?? 0
        case .weight:
            return stat.mostRecentQuantity()?.doubleValue(for: .pound()) ?? 0
        }
    }
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
