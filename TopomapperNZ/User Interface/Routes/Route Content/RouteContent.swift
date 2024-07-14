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
    
    @State internal var routePointsByDays = [Int: [RoutePoint]]()
    
    private let mapFrameHeight: CGFloat = 350
    
    // MARK: - Body
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
                
                RoutePointsStatistics(points: route.points)
                
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
                
                ForEach(0..<routePointsByDays.count, id: \.self) { i in
                    Text("Day \(i + 1)")
                        .font(.headline)
                    
                    RoutePointsStatistics(points: routePointsByDays[i + 1]!)
                }
            } // VStack
            .padding()
        } // ScrollView
        .onAppear(perform: setProperties)
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
    
    internal func setProperties() {
        self.routePointsByDays = route.pointsByDays
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
