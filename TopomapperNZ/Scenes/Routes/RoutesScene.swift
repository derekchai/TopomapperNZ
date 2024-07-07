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
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            RoutesSidebar(selectedRoute: $selectedRoute)
                .navigationTitle("My Routes")
        } content: {
            if let selectedRoute {
                RoutesContent(
                    preferredColumn: $preferredColumn,
                    route: selectedRoute
                )
                    .navigationTitle(selectedRoute.name)
            } else {
                Text("Select a Route")
            }
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    RoutesScene()
}
