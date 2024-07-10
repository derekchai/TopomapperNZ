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
            VStack(alignment: .leading) {
                Text(route.name)
                    .font(.headline)
                
                Text(route.creationDate.formatted())
                    .font(.subheadline)
                
                HStack {
                    Text("\(route.length.formatted(.routeLength))")
                    Image(systemName: Symbol.distance)
                    
                    Text(
                        "\(route.cumulativeElevationGain.formatted(.elevation))"
                    )
                    Image(systemName: Symbol.elevationGain)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RouteListItem(route: Route.sampleData.first!)
}
