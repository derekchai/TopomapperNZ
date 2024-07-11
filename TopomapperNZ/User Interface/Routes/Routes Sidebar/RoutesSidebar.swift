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
    @State internal var sortMode: SortMode = .creationDate
    
    @Environment(\.modelContext) internal var modelContext
    @Query internal var routes: [Route]
    
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
            
            ToolbarItem(placement: .secondaryAction) {
                Picker("Sort mode", systemImage: Symbol.sortBy, selection: $sortMode) {
                    ForEach(SortMode.allCases) { mode in
                        Text(mode.rawValue)
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingNewRouteSheet) {
            NewRouteSheet()
        }
    }
}

// MARK: - RoutesSidebar.SortMode Enumeration
extension RoutesSidebar {
    enum SortMode: String, CaseIterable, Identifiable {
        case name = "Name"
        case creationDate = "Creation Date"
        
        var id: Self { self }
    }
}

#Preview {
    @Previewable @State var routeSelection: Route? = nil
    
    RoutesSidebar(selectedRoute: $routeSelection)
}
