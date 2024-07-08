//
//  Route.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import SwiftData

@Model
final class Route {
    var name: String
    var creationDate: Date
    var points: [RoutePoint]
    
    // MARK: - Initializers
    init(name: String, creationDate: Date, points: [RoutePoint]) {
        self.name = name
        self.creationDate = creationDate
        self.points = points
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        points = try container.decode([RoutePoint].self, forKey: .points)
    }
}
