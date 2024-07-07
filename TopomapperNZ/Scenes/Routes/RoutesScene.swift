//
//  RoutesScene.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesScene: View {
    @State private var selectedRoute: Route? = nil
    
    var body: some View {
        NavigationSplitView {
            RoutesSidebar(selectedRoute: $selectedRoute)
                .navigationTitle("My Routes")
        } content: {
            if let selectedRoute {
                RoutesContent(route: selectedRoute)
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
