//
//  EditRouteSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import SwiftUI

struct EditRouteSheet: View {
    @Environment(\.dismiss) internal var dismiss
    @Environment(AppState.self) internal var appState
    
    @State internal var routeName: String
    @State internal var didEditRoute = false
    
    init(route: Route) {
        self.routeName = route.name
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Route name") {
                    TextField("New name", text: $routeName)
                }
            } // Form
            .navigationTitle("Edit Route")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: updateRoute)
                        .disabled(!didEditRoute)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancelEdit)
                }
            }
        } // NavigationStack
        .onChange(of: routeName, updateDidEditRoute)
    }
}

// MARK: - Actions
extension EditRouteSheet {
    /// Updates the `Route` being edited's properties to the new provided
    /// properties, and then dismisses the sheet.
    internal func updateRoute() {
        guard let selectedRoute = appState.selectedRoute else { return }
        
        selectedRoute.rename(to: routeName)
        dismiss()
    }
    
    /// Cancel editing the `Route` and dismiss the sheet.
    internal func cancelEdit() {
        dismiss()
    }
    
    /// Update `didEditRoute`, which expresses whether the user has or has not
    /// edited the `Route`'s properties to something different.
    internal func updateDidEditRoute() {
        guard let selectedRoute = appState.selectedRoute else { return }
        
        let originalRouteName = selectedRoute.name
        
        if routeName == originalRouteName {
            didEditRoute = false
        } else {
            didEditRoute = true
        }
    }
}

#Preview {
    EditRouteSheet(route: Route.sampleData.first!)
}
