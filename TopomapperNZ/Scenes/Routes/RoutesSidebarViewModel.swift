//
//  RoutesSidebarViewModel.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import SwiftUI

extension RoutesSidebar {
    @Observable
    class ViewModel {
        var isPresentingNewRouteSheet = false
        
        private(set) var routes = Route.sampleData
        
        // MARK: - Functions
        func presentNewRouteSheet() {
            isPresentingNewRouteSheet = true
        }
    }
}
