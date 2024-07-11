//
//  RouteListItem.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import MapKit

struct RouteListItem: View {
    var route: Route
    
    var body: some View {
        HStack {
            RoutePathShape(route: route)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(route.name)
                    .font(.headline)
                
                HStack {
                    Statistic(
                        label: "Length",
                        systemImageName: Symbol.distance,
                        value: route.length.formatted(.routeLength)
                    )
                    
                    Statistic(
                        label: "Alt. Gain",
                        systemImageName: Symbol.elevationGain,
                        value: route.cumulativeElevationGain
                            .formatted(.elevation)
                    )
                }
                
                Text(route.creationDate.formatted())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RouteListItem(route: Route.sampleData.first!)
}
