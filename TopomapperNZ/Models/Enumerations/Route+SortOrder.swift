//
//  Route+SortOrder.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 11/07/2024.
//

import Foundation

extension Route {
    enum SortOrder: CaseIterable, Identifiable {
        case forward
        case reverse
        
        var id: Self { self }
        
        var sortOrder: Foundation.SortOrder {
            switch self {
            case .forward:
                    .forward
            case .reverse:
                    .reverse
            }
        }
        
        /// Returns a display string based on the given sort mode.
        func displayName(sortMode: Route.SortMode) -> String {
            switch sortMode {
            case .name:
                switch self {
                case .forward:
                    "Ascending"
                case .reverse:
                    "Descending"
                }
            case .creationDate:
                switch self {
                case .forward:
                    "Oldest First"
                case .reverse:
                    "Newest First"
                }
            }
        }
    }
}
