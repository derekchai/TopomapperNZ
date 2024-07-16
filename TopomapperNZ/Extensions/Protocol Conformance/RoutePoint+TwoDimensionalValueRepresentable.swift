//
//  RoutePoint+TwoDimensionalValueRepresentable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 16/07/2024.
//

import Foundation

extension RoutePoint: TwoDimensionalValueRepresentable {
    var x: Double {
        self.distanceFromStart
    }

    var y: Double {
        self.elevation
    }
}
