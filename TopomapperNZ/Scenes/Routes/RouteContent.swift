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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // MARK: - Map
                    Text("Map")
                        .font(.headline)
                    
                    Map(interactionModes: []) {}
                        .frame(height: 350)
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
                            value: "38.0 km"
                        )
                        Divider()
                        Statistic(
                            label: "Alt. Gain",
                            systemImageName: Symbol.elevationGain,
                            value: "1,432 m"
                        )
                        Divider()
                        Statistic(
                            label: "Alt. Loss",
                            systemImageName: Symbol.elevationLoss,
                            value: "435 m"
                        )
                    }
                    
                    // MARK: - Elevation Profile
                    Text("Elevation Profile")
                        .header()
                    
                    Chart {
                        LinePlot(x: "x", y: "y = sin(x)") { sin($0) }
                            .foregroundStyle(by: .value("expression", "y=sin(x)"))
                            .opacity(0.8)
                    }
                    .chartXScale(domain: -10 ... 10)
                    .chartYScale(domain: -1 ... 1)
                    .frame(height: 200)
                    .onTapGesture(perform: showDetailColumn)
                    
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
        } // NavigationStack
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
