//
//  Route.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

final class Route {
    var name: String
    var creationDate: Date
    
    init(name: String, creationDate: Date) {
        self.name = name
        self.creationDate = creationDate
    }
    
    // MARK: - Equatable Conformance
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.name == rhs.name && lhs.creationDate == rhs.creationDate
    }
    
    // MARK: - Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(creationDate)
    }
}
