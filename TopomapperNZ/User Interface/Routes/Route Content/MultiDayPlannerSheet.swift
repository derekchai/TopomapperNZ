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
            List {
                Section("Route Map") {
                    MultiDayPlannerMapViewControllerRepresentable(
                        stops: $stops,
                        route: route,
                        mapFrameHeight: 350,
                        onUpdateSelectedRoutePoint: addRoutePointToStops
                    )
                    .frame(height: 350)
                    .listRowInsets(EdgeInsets())
                }
                
                Section("Stops") {
                    if stops.isEmpty {
                        ContentUnavailableView(
                            "No Stops added",
                            systemImage: Symbol.noStops,
                            description: Text("Tap on a point on the Route's path to add a stop there!")
                        )
                    } else {
                        ForEach(stops) { stop in
                            Text(String(String(describing: stop.coordinate)))
                        }
                        .onDelete(perform: deleteStops)
                    }
                }
            } // List
            .navigationTitle("Multi-Day Planner")
            
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
    
    /// Deletes stops at the given `indices`.
    /// - Parameter indices: An `IndexSet` of all the indices where stops should
    /// be deleted.
    internal func deleteStops(at indices: IndexSet) {
        stops.remove(atOffsets: indices)
    }
}

#Preview {
    MultiDayPlannerSheet(route: Route.sampleData.first!)
}
