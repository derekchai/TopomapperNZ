//
//  RoutesSidebar.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import SwiftData

struct RoutesSidebar: View {
    @Binding var searchText: String
    
    @State internal var isPresentingNewRouteSheet = false
    
    @Environment(\.modelContext) internal var modelContext
    @Environment(AppState.self) internal var appState
    @Query internal var routes: [Route]
    
    // MARK: - Computed Properties
    private var displayedRoutes: [Route] {
        guard !searchText.isEmpty else { return routes }
        
        return routes.filter { route in
            route.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // MARK: - Initializer
    init(
        searchText: Binding<String>,
        routeSortMode: Route.SortMode,
        routeSortOrder: Route.SortOrder
    ) {
        _searchText = searchText
        
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
                @Bindable var navigationState = appState
                
                List(selection: $navigationState.selectedRoute) {
                    ForEach(displayedRoutes) { route in
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
