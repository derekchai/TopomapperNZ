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
    
    // MARK: - Initializer
    init(
        selectedRoute: Binding<Route?>,
        routeSortMode: Route.SortMode,
        routeSortOrder: Route.SortOrder
    ) {
        _selectedRoute = selectedRoute
        
        switch routeSortMode {
        case .name:
            _routes = Query(
                sort: [SortDescriptor(\Route.name, order: routeSortOrder.sortOrder)]
            )
        case .creationDate:
            _routes = Query(
                sort: [SortDescriptor(\Route.creationDate, order: routeSortOrder.sortOrder)]
            )
        }
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if routes.isEmpty {
                ContentUnavailableView(
                    "No Routes created",
                    systemImage: Symbol.path,
                    description: Text("Create a new Route to get started!")
                )
            } else {
                List(selection: $selectedRoute) {
                    ForEach(routes) { route in
                        NavigationLink(value: route) {
                            RouteListItem(route: route)
                        }
                    }
                    .onDelete(perform: removeRoutes)
                }
                
            }
        } // Group
        .navigationTitle("My Routes")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(
                    "New Route",
                    systemImage: Symbol.add,
                    action: presentNewRouteSheet
                )
            }
        }
        .sheet(isPresented: $isPresentingNewRouteSheet) {
            NewRouteSheet()
        }
    }
}


//#Preview {
//    @Previewable @State var routeSelection: Route? = nil
//    
//    RoutesSidebar(selectedRoute: $routeSelection, sortDescriptor: )
//}
