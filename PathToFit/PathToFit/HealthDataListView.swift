//
//  HealthDataListView.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/22/24.
//

import SwiftUI

struct HealthDataListView: View {
    @State private var isShowingAddData = false
    @State private var addDataDate: Date = .now
    @State private var valueToAdd: String = ""
    
    var metric: HealthMetricContext
    
    var body: some View {
        List(0..<28, id: \.self) { i in
            HStack {
                Text(Date(), format: .dateTime.month().day().year())
                
                Spacer()
                
                Text(10000, format: .number.precision(.fractionLength(metric.precision)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            addDataView
        }
        .toolbar {
            Button("Add Data", systemImage: "plus") {
                isShowingAddData = true
            }
        }
    }
    
    var addDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $addDataDate, displayedComponents: .date)
                
                HStack {
                    Text(metric.title)
                    
                    Spacer()
                    
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric.keypadType)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        isShowingAddData = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}

extension HealthMetricContext {
    var precision: Int {
        switch self {
        case .steps:
            0
        case .weight:
            1
        }
    }
    
    var keypadType: UIKeyboardType {
        switch self {
        case .steps:
            .numberPad
        case .weight:
            .decimalPad
        }
    }
}
