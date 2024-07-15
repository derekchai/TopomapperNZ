//
//  RouteElevationProfileChart.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 11/07/2024.
//

import SwiftUI
import Charts

struct RouteElevationProfileChart: View {
    let route: Route
    @Binding var isElevationProfileExpanded: Bool
    
    @State private var rawXSelection: Double?
    @State private var routePointSelection: RoutePoint?
    private let stops: [RoutePoint]
    
    // MARK: - Initializer
    init(
        route: Route,
        isElevationProfileExpanded: Binding<Bool>
    ) {
        self.route = route
        _isElevationProfileExpanded = isElevationProfileExpanded
        
        stops = route.stops
    }
    
    var body: some View {
        Chart {
            LinePlot(
                route.points,
                x: .value("Distance from start", \.distanceFromStart),
                y: .value("Elevation", \.elevation)
            )
            
            if let rawXSelection {
                RuleMark(x: .value("Distance", rawXSelection))
                    .foregroundStyle(.gray.opacity(0.6))
                    .offset(yStart: -10)
                    .zIndex(-1)
            }
            
            ForEach(stops) { stop in
                RuleMark(x: .value("Distance", stop.distanceFromStart))
                    .foregroundStyle(.blue.opacity(0.3))
                    .offset(yStart: -10)
                    .zIndex(-1)
                    .annotation {
                        Image(systemName: "\(stop.day!).circle.fill")
                            .foregroundStyle(.blue.opacity(0.5))
                            .font(.system(size: 11))
                    }
            }
        }
        .frame(height: 200)
        .chartXAxis {
            AxisMarks(format: .routeLength)
        }
        .chartYAxis {
            AxisMarks(format: .elevation)
        }
        .chartXSelection(value: $rawXSelection)
        .if(isElevationProfileExpanded) { view in
            view.chartScrollableAxes(.horizontal)
        }
        .onChange(of: rawXSelection, updateRoutePointSelection)
        .padding(.top)
    }
}

// MARK: - Actions
extension RouteElevationProfileChart {
    internal func updateRoutePointSelection(_: Double?, _ newRawXSelectionValue: Double?) {
        if let newRawXSelectionValue {
            routePointSelection = route.points.nearestPoint(to: newRawXSelectionValue)
        } else {
            routePointSelection = nil
        }
    }
}

#Preview {
    @Previewable @State var isElevationProfileExpanded = false
    RouteElevationProfileChart(
        route: Route.sampleData.first!, isElevationProfileExpanded: $isElevationProfileExpanded
    )
}
