//
//  DashboardView.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/18/24.
//

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
                    NavigationLink(value: selectedStat) {
                        StepsCard()
                    }
                    .foregroundStyle(.secondary)
                        
                    
                    // MARK: - Averages Card
                    AveragesCard()
                }
            }
            .padding()
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                Text(metric.title)
            }
        }
        .tint(selectedStat.tint)
    }
}

#Preview {
    DashboardView()
}

// MARK: - Extracted subviews - cleanup and refactor later.

struct StepsCard: View {
    var body: some View {
        VStack {
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
            .padding(.bottom, 12)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 150)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        }
    }
}

struct AveragesCard: View {
    var body: some View {
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
