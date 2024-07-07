//
//  RoutesContent.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesContent: View {
    var route: Route
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(route.creationDate.formatted())
            Text("Route content goes here...")
        }
    }
}

#Preview {
    RoutesContent(route: Route.sampleData.first!)
}
