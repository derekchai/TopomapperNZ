//
//  RoutesSidebar.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct RoutesSidebar: View {
    var body: some View {
        List {
            RouteListItem()
            RouteListItem()
            RouteListItem()
        }
    }
}

#Preview {
    RoutesSidebar()
}
