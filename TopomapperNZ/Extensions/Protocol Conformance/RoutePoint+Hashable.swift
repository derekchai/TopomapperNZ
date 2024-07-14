//
//  RoutePoint+Hashable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 14/07/2024.
//

import Foundation

extension RoutePoint: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate)
        hasher.combine(elevation)
        hasher.combine(distanceFromStart)
        hasher.combine(grade)
        hasher.combine(day)
    }
}
