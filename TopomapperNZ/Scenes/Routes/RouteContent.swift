//
//  RouteContent.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import MapKit

struct RouteContent: View {
    @Binding var preferredColumn: NavigationSplitViewColumn
    var route: Route
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Map(interactionModes: []) {}
                    .frame(height: 400)
                    .onTapGesture {
                        preferredColumn = .detail
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(route.creationDate.formatted())
                Text("Route content goes here...")
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var preferredColumn = NavigationSplitViewColumn.content
    
    RouteContent(
        preferredColumn: $preferredColumn, route: Route.sampleData.first!
    )
}
