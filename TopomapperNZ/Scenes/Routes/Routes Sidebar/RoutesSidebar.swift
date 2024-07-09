//
//  RoutesSidebar.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import SwiftData

struct RoutesSidebar: View {
    @Binding var selectedRoute: Route?
    
    @State internal var isPresentingNewRouteSheet = false

    @Environment(\.modelContext) internal var modelContext
    @Query internal var routes: [Route]
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedRoute) {
                ForEach(routes) { route in
                    NavigationLink(value: route) {
                        RouteListItem(route: route)
                    }
                }
                .onDelete(perform: removeRoutes)
            }
            .navigationTitle("My Routes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("New Route", action: presentNewRouteSheet)
                }
            }
        }
        .sheet(isPresented: $isPresentingNewRouteSheet) {
            NewRouteSheet()
        }
    }
}

#Preview {
    @Previewable @State var routeSelection: Route? = nil
    
    RoutesSidebar(selectedRoute: $routeSelection)
}
