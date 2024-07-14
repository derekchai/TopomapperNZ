//
//  RoutesScene.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesScene: View {
    @State private var selectedRoute: Route? = nil
    @State private var preferredColumn = NavigationSplitViewColumn.sidebar
    @State private var searchText = ""
    
    @State private var sortMode: Route.SortMode = .creationDate
    @State private var sortOrder: Route.SortOrder = .forward
    
    var body: some View {
        
        // MARK: - Sidebar
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            RoutesSidebar(
                searchText: $searchText,
                routeSortMode: sortMode,
                routeSortOrder: sortOrder
            )
            .toolbar {
                ToolbarItem(placement: .secondaryAction) {
                    Menu("Sort by", systemImage: Symbol.sortBy) {
                        Picker("Sort mode", selection: $sortMode) {
                            ForEach(Route.SortMode.allCases) { mode in
                                Text(mode.displayName)
                            }
                        }
                        
                        Picker("Sort order", selection: $sortOrder) {
                            ForEach(Route.SortOrder.allCases) { order in
                                Text(order.displayName(sortMode: sortMode))
                            }
                        }
                    }
                }
            }
            
            // MARK: - Content
        } content: {
            if let selectedRoute {
                RouteContent(
                    preferredColumn: $preferredColumn,
                    route: selectedRoute
                )
            } else {
                Text("Select a Route")
            }
            
            // MARK: - Detail
        } detail: {
            if let selectedRoute {
                RouteDetail(route: selectedRoute)
            } else {
                Text("Select a Route")
            }
        }
        .searchable(text: $searchText, prompt: "Search Routes")
    }
}

// MARK: - Preview
#Preview {
    RoutesScene()
}
