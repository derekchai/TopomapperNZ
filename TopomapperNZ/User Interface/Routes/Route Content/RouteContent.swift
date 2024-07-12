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
    @State internal var isPresentingMultiDayPlannerSheet = false
    
    @State internal var isElevationProfileExpanded = false
    
    private let mapFrameHeight: CGFloat = 350
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // MARK: - Map
#if os(iOS)
                SectionHeader(title: "Route Map")
                
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
#endif
                
                // MARK: - Statistics
                SectionHeader(title: "Statistics")
                    .padding(.top)
                
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
#if os(iOS)
                SectionHeader(title: "Elevation Profile") {
                    if isElevationProfileExpanded {
                        contractedElevationProfileButton
                    } else {
                        expandedElevationProfileButton
                    }
                }
                .padding(.top)
                
                RouteElevationProfileChart(
                    route: route, isElevationProfileExpanded: $isElevationProfileExpanded
                )
                .onTapGesture(perform: showDetailColumn)
#endif
                
                // MARK: - Breakdown by Day
                SectionHeader(title: "Breakdown by Day") {
                    Button("Add Day") { isPresentingMultiDayPlannerSheet = true }
                }
                    .padding(.top)
                
                Text("Day 1")
                    .font(.headline)
                
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
        .sheet(isPresented: $isPresentingMultiDayPlannerSheet) {
            MultiDayPlannerSheet(route: route)
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

// MARK: - Preview
#Preview {
    @Previewable @State var preferredColumn = NavigationSplitViewColumn.content
    
    RouteContent(
        preferredColumn: $preferredColumn, route: Route.sampleData.first!
    )
}
