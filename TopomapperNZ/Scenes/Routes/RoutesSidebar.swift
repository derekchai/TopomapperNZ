//
//  RoutesSidebar.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesSidebar: View {
    @Binding var selectedRoute: Route?
    
    @State private var routes = Route.sampleData
    
    var body: some View {
        NavigationStack {
            List(routes, id: \.self, selection: $selectedRoute) { route in
                NavigationLink(value: route) {
                    RouteListItem(route: route)
                }
            }
            .navigationTitle("My Routes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Import GPX") {}
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var routeSelection: Route? = nil
    
    RoutesSidebar(selectedRoute: $routeSelection)
}
