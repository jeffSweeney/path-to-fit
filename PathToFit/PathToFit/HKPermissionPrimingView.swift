//
//  HKPermissionPrimingView.swift
//  PathToFit
//
//  Created by Jeffrey Sweeney on 8/22/24.
//

import SwiftUI
import HealthKitUI

struct HKPermissionPrimingView: View {
    @Environment(HKManager.self) private var hkManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingHKPermissions = false
    @Binding var hasSeen: Bool
    
    var body: some View {
        VStack(spacing: 130) {
            VStack(alignment: .leading, spacing: 12) {
                Image(.appleHealthIcon)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3),radius: 16)
                    .padding(.bottom, 12)
                
                Text("Apple Health Integration")
                    .font(.title2)
                    .bold()
                
                Text(description)
                    .foregroundStyle(.secondary)
            }
            
            Button("Connect Apple Health") {
                isShowingHKPermissions = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
        .interactiveDismissDisabled()
        .onAppear { hasSeen = true }
        .healthDataAccessRequest(store: hkManager.store,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingHKPermissions) { result in
            switch result {
            case .success:
                dismiss()
            case .failure:
                // TODO: - Handle error
                dismiss()
            }
        }
        
    }
}

extension HKPermissionPrimingView {
    var description: String { 
    """
    This app displays your step and weight data in interactive charts.
    
    You can also add new step or weight data to Apple Health from this app. Your data is private and secure.
    """
    }
}

#Preview {
    HKPermissionPrimingView(hasSeen: .constant(true))
        .environment(HKManager())
}
