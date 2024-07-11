//
//  Route+SortMode.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 11/07/2024.
//

import Foundation

extension Route {
    enum SortMode: CaseIterable, Identifiable {
        case name
        case creationDate
        
        var id: Self { self }
        
        var displayName: String {
            switch self {
            case .name:
                "Name"
            case .creationDate:
                "Creation Date"
            }
        }
    }
}
