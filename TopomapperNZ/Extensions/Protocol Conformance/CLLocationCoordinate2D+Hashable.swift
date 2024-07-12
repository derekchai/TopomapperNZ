//
//  CLLocationCoordinate2D+Hashable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
