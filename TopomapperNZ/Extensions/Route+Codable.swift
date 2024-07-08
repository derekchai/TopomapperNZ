//
//  Route+Codable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

extension Route: Codable {
    enum CodingKeys: CodingKey {
        case name
        case creationDate
        case points
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(points, forKey: .points)
    }
}
