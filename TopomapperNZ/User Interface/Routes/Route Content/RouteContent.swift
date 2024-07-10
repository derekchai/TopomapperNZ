//
//  RouteContent.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import MapKit
import Charts

struct RouteContent: View {
    @Binding var preferredColumn: NavigationSplitViewColumn
    let route: Route
    
    @State internal var isPresentingEditRouteSheet = false
    
    @State internal var isElevationProfileExpanded = false
    
    private let mapFrameHeight: CGFloat = 350
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // MARK: - Map
                Text("Map")
                    .font(.headline)
                
                RouteMapViewControllerRepresentable(
                    route: route,
                    mapFrameHeight: mapFrameHeight
                )
                    .frame(height: mapFrameHeight)
                    .onTapGesture(perform: showDetailColumn)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Created on \(route.creationDate.formatted())")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                // MARK: - Statistics
                Text("Statistics")
                    .header()
                
                HStack {
                    Statistic(
                        label: "Length",
                        systemImageName: Symbol.distance,
                        value: route.length.formatted(.routeLength)
                    )
                    Divider()
                    Statistic(
                        label: "Alt. Gain",
                        systemImageName: Symbol.elevationGain,
                        value: route.cumulativeElevationGain
                            .formatted(.elevation)
                    )
                    Divider()
                    Statistic(
                        label: "Alt. Loss",
                        systemImageName: Symbol.elevationLoss,
                        value: route.cumulativeElevationLoss
                            .formatted(.elevation)
                    )
                }
                
                // MARK: - Elevation Profile
                HStack(alignment: .lastTextBaseline) {
                    Text("Elevation Profile")
                        .header()
                    
                    Spacer()
                    
                    Group {
                        if isElevationProfileExpanded {
                            contractedElevationProfileButton
                        } else {
                            expandedElevationProfileButton
                        }
                    }
                }
                
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
                .onTapGesture(perform: showDetailColumn)
                .if(isElevationProfileExpanded) { view in
                    view.chartScrollableAxes(.horizontal)
                }
                
                // MARK: - Breakdown by Day
                Text("Breakdown by Day")
                    .header()
                
                Text("Day 1")
                    .font(.subheadline)
                Text("Day 2")
                    .font(.subheadline)
                Text("Day 3")
                    .font(.subheadline)
                
            } // VStack
            .padding()
        } // ScrollView
        .navigationTitle(route.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit", action: presentEditRouteSheet)
            }
        }
        .sheet(isPresented: $isPresentingEditRouteSheet) {
            EditRouteSheet(route: route)
        }
    }
}

// MARK: - Components
extension RouteContent {
    private var expandedElevationProfileButton: some View {
        Button(
            "",
            systemImage: Symbol.expandHorizontal,
            action: expandElevationProfile
        )
    }
    
    private var contractedElevationProfileButton: some View {
        Button(
            "",
            systemImage: Symbol.contractHorizontal,
            action: contractElevationProfile
        )
    }
}

// MARK: - Actions
extension RouteContent {
    internal func showDetailColumn() {
        preferredColumn = .detail
    }
    
    internal func presentEditRouteSheet() {
        isPresentingEditRouteSheet = true
    }
    
    internal func expandElevationProfile() {
        isElevationProfileExpanded = true
    }
    
    internal func contractElevationProfile() {
        isElevationProfileExpanded = false
    }
}

// MARK: - View Extensions
/// The amount of padding above each section's header (excluding the first
/// section).
fileprivate let sectionPadding: CGFloat = 25

fileprivate extension View {
    func header() -> some View {
        self
            .font(.headline)
            .padding(.top, sectionPadding)
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var preferredColumn = NavigationSplitViewColumn.content
    
    RouteContent(
        preferredColumn: $preferredColumn, route: Route.sampleData.first!
    )
}
