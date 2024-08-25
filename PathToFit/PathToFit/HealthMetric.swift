//
//  HealthMetric.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/25/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
