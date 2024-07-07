//
//  RoutesScene.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesScene: View {
    var body: some View {
        NavigationSplitView {
            RoutesSidebar()
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
