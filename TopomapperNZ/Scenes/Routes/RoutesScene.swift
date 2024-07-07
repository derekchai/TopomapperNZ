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
            Text("Content")
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    RoutesScene()
}
