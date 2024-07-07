//
//  RouteListItem.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RouteListItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Kaweka Traverse")
                .font(.headline)
        
            Text("8 July 2024")
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

#Preview {
    RouteListItem()
}
