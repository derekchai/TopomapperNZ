//
//  RoutesSidebar+Actions.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import Foundation

extension RoutesSidebar {
    internal func presentNewRouteSheet() {
        isPresentingNewRouteSheet = true
    }
    
    internal func removeRoutes(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(routes[index])
        }
    }
}
