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
    
    // MARK: - Exposed Properties
    @Binding var preferredColumn: NavigationSplitViewColumn
    var route: Route
    
    // MARK: - Private Properties
    @State internal var isPresentingEditRouteSheet = false
    @State internal var isPresentingMultiDayPlannerSheet = false
    @State internal var isElevationProfileExpanded = false
    
    // MARK: - Computed Properties
    internal var routePointsByDays: [Int: [RoutePoint]] {
        route.pointsByDays
    }
    
    // MARK: - Private Constants
    private let mapFrameHeight: CGFloat = 350
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // MARK: - Statistics
                SectionHeader(title: "Statistics")
                    .padding(.top)
                
                RoutePointsStatistics(points: route.points)
                
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
                
#endif
                
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
                    Button("Add Stops") { isPresentingMultiDayPlannerSheet = true }
                }
                    .padding(.top)
                
                if routePointsByDays.isEmpty {
                    ContentUnavailableView(
                        "No Multi-Day Itinerary Planned",
                        systemImage: Symbol.path,
                        description: Text("Press the 'Add Stops' button to plan a multi-day trip.")
                    )
                } else {
                    ForEach(0..<routePointsByDays.count, id: \.self) { i in
                        Text("Day \(i + 1)")
                            .font(.headline)
                        
                        RoutePointsStatistics(points: routePointsByDays[i + 1] ?? [])
                    }
                }
                
                Divider()
                
                Text("Route created on \(route.creationDate.formatted())")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
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
//#Preview {
//    @Previewable @State var preferredColumn = NavigationSplitViewColumn.content
//    
//    RouteContent(
//        preferredColumn: $preferredColumn, route: Route.sampleData.first!
//    )
//}
