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
    private let simplifiedRoutePoints: [RoutePoint]
    
    private let chartData: [RoutePoint]
    private let areaGradient = LinearGradient(
        colors: [.blue.opacity(0.5), .blue.opacity(0.2), .blue.opacity(0.05)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // MARK: - Initializer
    init(
        route: Route,
        isElevationProfileExpanded: Binding<Bool>
    ) {
        self.route = route
        _isElevationProfileExpanded = isElevationProfileExpanded
        
        stops = route.stops
        simplifiedRoutePoints = route.points.decimated(target: 150)
        
        let epsilon = log(Double(route.points.count)) / 10
        chartData = route.points.decimated(ε: epsilon)
    }
    
    var body: some View {
        Chart {
            LinePlot(
                chartData,
                x: .value("Distance from start", \.distanceFromStart),
                y: .value("Elevation", \.elevation)
            )
            
            AreaPlot(
                chartData,
                x: .value("Distance from start", \.distanceFromStart),
                y: .value("Elevation", \.elevation)
            )
            .foregroundStyle(areaGradient)
            
            if let rawXSelection {
                RuleMark(x: .value("Distance", rawXSelection))
                    .foregroundStyle(.gray.opacity(0.6))
                    .offset(yStart: -10)
                    .zIndex(-1)
                    .annotation(
                        position: .top,
                        spacing: 15,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled
                        )) {
                            if let routePointSelection {
                                HStack {
                                    Statistic(
                                        label: "From start",
                                        systemImageName: Symbol.distanceFromStart,
                                        value: routePointSelection.distanceFromStart
                                            .formatted(.routeLength)
                                    )
                                    
                                    Statistic(
                                        label: "Elevation",
                                        systemImageName: Symbol.elevation,
                                        value: routePointSelection.elevation
                                            .formatted(.elevation)
                                    )
                                    
                                    Statistic(
                                        label: "Grade",
                                        systemImageName: Symbol.grade,
                                        value: routePointSelection.grade
                                            .formatted(.grade)
                                    )
                                }
                            }
                        }
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
        
        Group {
            Text("Original n: \(route.points.count)")
            Text("Chart data n: \(chartData.count)")
            Text("Point matching n: \(simplifiedRoutePoints.count)")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}

// MARK: - Actions
extension RouteElevationProfileChart {
    internal func updateRoutePointSelection(_: Double?, _ newRawXSelectionValue: Double?) {
        if let newRawXSelectionValue {
            routePointSelection = simplifiedRoutePoints.nearestPoint(to: newRawXSelectionValue)
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
