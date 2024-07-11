//
//  RouteElevationProfileChart.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 11/07/2024.
//

import SwiftUI
import Charts

struct RouteElevationProfileChart: View {
    @Binding var isElevationProfileExpanded: Bool
    let route: Route
    
    var body: some View {
        Chart {
            LinePlot(
                route.points,
                x: .value("Distance from start", \.distanceFromStart),
                y: .value("Elevation", \.elevation)
            )
        }
        .frame(height: 200)
        .chartXAxis {
            AxisMarks(format: .routeLength)
        }
        .chartYAxis {
            AxisMarks(format: .elevation)
        }
        .if(isElevationProfileExpanded) { view in
            view.chartScrollableAxes(.horizontal)
        }
    }
}

#Preview {
    @Previewable @State var isElevationProfileExpanded = false
    RouteElevationProfileChart(
        isElevationProfileExpanded: $isElevationProfileExpanded,
        route: Route.sampleData.first!
    )
}
