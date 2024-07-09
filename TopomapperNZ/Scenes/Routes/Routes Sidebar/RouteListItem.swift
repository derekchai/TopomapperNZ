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
                    Text("74.3 km")
                    Image(systemName: Symbol.distance)
                    
                    Text("1294 m")
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
