//
//  RoutePoint+Equatable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 14/07/2024.
//

import Foundation

extension RoutePoint: Equatable {
    static func == (lhs: RoutePoint, rhs: RoutePoint) -> Bool {
        return lhs.coordinate == rhs.coordinate
    }
}
