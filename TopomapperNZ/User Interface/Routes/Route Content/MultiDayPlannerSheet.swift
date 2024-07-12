//
//  EditDaysSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import SwiftUI

struct MultiDayPlannerSheet: View {
    let route: Route
    
    @State private var stops: [RoutePoint] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    MultiDayPlannerMapViewControllerRepresentable(
                        route: route,
                        mapFrameHeight: 350,
                        onUpdateSelectedRoutePoint: addRoutePointToStops
                    )
                    .frame(height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                .navigationTitle("Multi-Day Planner")
            }
        }
    }
}

extension MultiDayPlannerSheet {
    /// Adds the given `RoutePoint` to the list of stops for this multi-day
    /// `Route`. The `RoutePoint`s are added such that `stops` is in order of
    /// ascending distance from start.
    /// - Parameter routePoint: The `RoutePoint` to add.
    internal func addRoutePointToStops(_ routePoint: RoutePoint?) {
        guard let routePoint else { return }
        
        guard !stops.isEmpty else {
            stops.append(routePoint)
            return
        }
        
        let insertionIndex = stops.firstIndex { // Where
            routePoint.distanceFromStart < $0.distanceFromStart
        }
        
        guard let insertionIndex else {
            stops.append(routePoint)
            return
        }
        
        stops.insert(routePoint, at: insertionIndex)
    }
}

#Preview {
    MultiDayPlannerSheet(route: Route.sampleData.first!)
}
