//
//  ContentView.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // MARK: - Entire Screen
                VStack(spacing: 20) {
                    // MARK: - Steps Card
                    StepsCard()
                    
                    // MARK: - Averages Card
                    AveragesCard()
                }
            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    ContentView()
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
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 12)
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.secondary)
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
