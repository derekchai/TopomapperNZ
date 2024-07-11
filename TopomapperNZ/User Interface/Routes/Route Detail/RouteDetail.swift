//
//  RouteDetail.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 11/07/2024.
//

import SwiftUI
import MapKit
import Charts

struct RouteDetail: View {
    let route: Route
    
    @State private var mapSize: CGSize = .zero
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                RouteMapViewControllerRepresentable(
                    route: route,
                    mapFrameHeight: mapSize.height
                )
                .onAppear(perform: { setMapSize(to: proxy.size) })
            }
            
            RouteElevationProfileChart(
                route: route,
                isElevationProfileExpanded: .constant(false)
            )
        }
        .navigationTitle(route.name)
    }
}

// MARK: - Actions
extension RouteDetail {
    internal func setMapSize(to size: CGSize) {
        self.mapSize = size
    }
}

#Preview {
    RouteDetail(route: Route.sampleData.first!)
}
