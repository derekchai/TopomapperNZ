//
//  Location+Distance.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension Location {
    func distance(from location: Location) -> CLLocationDistance {
        return self.coordinate.distance(from: location.coordinate)
    }
}
