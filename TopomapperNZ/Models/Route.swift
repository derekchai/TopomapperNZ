//
//  Route.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import SwiftData

@Model
final class Route: Hashable, Codable {
    var name: String
    var creationDate: Date
    var points: [RoutePoint]
    
    // MARK: - Initializer
    init(name: String, creationDate: Date, points: [RoutePoint]) {
        self.name = name
        self.creationDate = creationDate
        self.points = points
    }
    
    enum CodingKeys: CodingKey {
        case name
        case creationDate
        case points
    }
    
    // MARK: - Codable Conformance
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        points = try container.decode([RoutePoint].self, forKey: .points)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(points, forKey: .points)
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
