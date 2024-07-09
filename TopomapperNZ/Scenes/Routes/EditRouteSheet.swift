//
//  EditRouteSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import SwiftUI

struct EditRouteSheet: View {
    let route: Route
    
    @Environment(\.dismiss) internal var dismiss
    @State internal var routeName: String
    @State internal var didEditRoute = false
    
    init(route: Route) {
        self.route = route
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
    /// properties.
    internal func updateRoute() {
        route.rename(to: routeName)
    }
    
    /// Cancel editing the `Route` and dismiss the sheet.
    internal func cancelEdit() {
        dismiss()
    }
    
    /// Update `didEditRoute`, which expresses whether the user has or has not
    /// edited the `Route`'s properties to something different.
    internal func updateDidEditRoute() {
        let originalRouteName = route.name
        
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
