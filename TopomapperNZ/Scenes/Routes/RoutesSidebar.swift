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
                    Button("Import GPX", action: viewModel.presentFileImporter)
                }
            }
        }
        .fileImporter(
            isPresented: viewModel.isPresentingFileImporterBinding,
            allowedContentTypes: [.xml],
            allowsMultipleSelection: false,
            onCompletion: viewModel.handleFileImporterResult,
            onCancellation: {}
        )
    }
}

#Preview {
    @Previewable @State var routeSelection: Route? = nil
    
    RoutesSidebar(selectedRoute: $routeSelection)
}
