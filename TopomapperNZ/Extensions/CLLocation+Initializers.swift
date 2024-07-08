//
//  CLLocation+Initializers.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension CLLocation {
    convenience init(from location: Location) {
        self.init(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}
