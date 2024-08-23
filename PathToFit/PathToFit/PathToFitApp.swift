//
//  PathToFitApp.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/18/24.
//

import SwiftUI

@main
struct PathToFitApp: App {
    let manager = HKManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(manager)
        }
    }
}
