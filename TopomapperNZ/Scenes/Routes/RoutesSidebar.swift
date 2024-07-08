//
//  RoutesSidebar.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesSidebar: View {
    @Binding var selectedRoute: Route?
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.routes, id: \.self, selection: $selectedRoute) { route in
                NavigationLink(value: route) {
                    RouteListItem(route: route)
                }
            }
            .navigationTitle("My Routes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("New Route", action: viewModel.presentNewRouteSheet)
                }
            }
        }
        .sheet(isPresented: $viewModel.isPresentingNewRouteSheet) {
            NewRouteSheet()
        }
    }
}

#Preview {
    @Previewable @State var routeSelection: Route? = nil
    
    RoutesSidebar(selectedRoute: $routeSelection)
}
