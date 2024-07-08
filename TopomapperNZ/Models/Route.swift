//
//  Route.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

final class Route: Hashable {
    var name: String
    var creationDate: Date
    var points: [RoutePoint]
    
    // MARK: - Initializer
    init(name: String, creationDate: Date, points: [RoutePoint]) {
        self.name = name
        self.creationDate = creationDate
        self.points = points
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
