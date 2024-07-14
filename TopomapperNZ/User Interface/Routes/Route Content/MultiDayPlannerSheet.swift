//
//  EditDaysSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import SwiftUI

struct MultiDayPlannerSheet: View {
    @State private var stops: [RoutePoint] = []
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    
    var body: some View {
        NavigationStack {
            List {
                Section("Route Map") {
                    if let selectedRoute = appState.selectedRoute {
                        MultiDayPlannerMapViewControllerRepresentable(
                            stops: $stops,
                            route: selectedRoute,
                            mapFrameHeight: 350,
                            onUpdateSelectedRoutePoint: addRoutePointToStops
                        )
                        .frame(height: 350)
                        .listRowInsets(EdgeInsets())
                    }
                }
                
                Section("Stops") {
                    if stops.isEmpty {
                        ContentUnavailableView(
                            "No Stops added",
                            systemImage: Symbol.noStops,
                            description: Text("Tap on a point on the Route's path to add a stop there!")
                        )
                    } else {
                        ForEach(0..<stops.count, id: \.self) { i in
                            Label(
                                "\(stops[i].coordinate.latitude), \(stops[i].coordinate.longitude)",
                                systemImage: "\(i + 1).circle.fill"
                            )
                        }
                        .onDelete(perform: deleteStops)
                    }
                }
            } // List
            .navigationTitle("Multi-Day Planner")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveMultiDayPlan)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
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
    
    /// Deletes stops at the given `indices`.
    /// - Parameter indices: An `IndexSet` of all the indices where stops should
    /// be deleted.
    internal func deleteStops(at indices: IndexSet) {
        stops.remove(atOffsets: indices)
    }
    
    /// Dismisses the sheet without saving anything.
    internal func cancel() {
        self.dismiss()
    }
    
    internal func saveMultiDayPlan() {
        guard let route = appState.selectedRoute else { return }
        
        let routePoints = route.points
        var newRoutePoints = [RoutePoint]()
        
        var day = 1
        
        for point in routePoints {
            newRoutePoints
                .append(
                    RoutePoint(
                        coordinate: point.coordinate,
                        elevation: point.elevation,
                        distanceFromStart: point.distanceFromStart,
                        grade: point.grade,
                        day: day
                    )
                )
            
            if stops.contains(point) {
                day += 1
            }
        }
        
        route.setPoints(to: newRoutePoints)
        dismiss()
    }
}

#Preview {
//    MultiDayPlannerSheet(route: Route.sampleData.first!)
}
