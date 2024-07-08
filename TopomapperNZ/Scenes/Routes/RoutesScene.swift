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
    
    var body: some View {
        
        // MARK: - Sidebar
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            RoutesSidebar(selectedRoute: $selectedRoute)
                .navigationTitle("My Routes")
            
        // MARK: - Content
        } content: {
            if let selectedRoute {
                RouteContent(
                    preferredColumn: $preferredColumn,
                    route: selectedRoute
                )
                    .navigationTitle(selectedRoute.name)
            } else {
                Text("Select a Route")
            }
            
        // MARK: - Detail
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    RoutesScene()
}
