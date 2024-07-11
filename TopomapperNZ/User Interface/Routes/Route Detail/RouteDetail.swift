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
    
    var body: some View {
        VStack {
            Map {}
            
            RouteElevationProfileChart(
                route: route,
                isElevationProfileExpanded: .constant(false)
            )
        }
        .navigationTitle(route.name)
    }
}

#Preview {
    RouteDetail(route: Route.sampleData.first!)
}
