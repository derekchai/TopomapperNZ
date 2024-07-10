//
//  RoutesSidebar+Actions.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import Foundation
import os
import SwiftUI

extension RoutesSidebar {
    static private let logger = Logger(
        subsystem: TopomapperNZApp.subsystem,
        category: String(describing: RoutesSidebar.self)
    )
    
    internal func presentNewRouteSheet() {
        isPresentingNewRouteSheet = true
    }
    
    internal func removeRoutes(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(routes[index])
        }
    }
}
