//
//  DashboardView.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/18/24.
//

import Charts
import SwiftUI

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps
    case weight
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            "Steps"
        case .weight:
            "Weight"
        }
    }
    
    var tint: Color {
        switch self {
        case .steps:
            return .pink
        case .weight:
            return .indigo
        }
    }
}

struct DashboardView: View {
    @Environment(HKManager.self) private var hkManager
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    @State private var showingPermissionPrimingSheet: Bool = false
    @State private var selectedStat: HealthMetricContext = .steps
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // MARK: - Entire Screen
                VStack(spacing: 20) {
                    // MARK: - Health Stat Context
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // MARK: - Steps Card
                    VStack {
                        NavigationLink(value: selectedStat) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.pink)
                                    
                                    Text("Avg: 10k Steps")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 12)
                        
                        Chart {
                            ForEach(hkManager.stepData) { steps in
                                BarMark(x: .value("Date", steps.date, unit: .day),
                                        y: .value("Steps", steps.value))
                            }
                        }
                        .foregroundStyle(.pink)
                        .frame(height: 150)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                    }
                    
                    // MARK: - Averages Card
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(.pink)
                            
                            Text("Last 28 Days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                    }
                }
            }
            .padding()
            .task {
//                await hkManager.addSimData()
                await hkManager.fetchStepCount()
//                await hkManager.fetchWeights()
                showingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $showingPermissionPrimingSheet, onDismiss: {
                // Fetch health data
            }, content: {
                HKPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            })
        }
        .tint(selectedStat.tint)
    }
}

#Preview {
    DashboardView()
        .environment(HKManager())
}
