//
//  EditRouteSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import SwiftUI

struct EditRouteSheet: View {
    let route: Route
    
    @State private var routeName: String
    
    init(route: Route) {
        self.route = route
        self.routeName = route.name
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Route info") {
                    TextField("Route name", text: $routeName)
                }
            } // Form
            .navigationTitle("Edit Route")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {}
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {}
                }
            }
        } // NavigationStack
    }
}

#Preview {
    EditRouteSheet(route: Route.sampleData.first!)
}
