//
//  CLLocation+Initializers.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension CLLocation {
    convenience init(from gpxTrackPoint: GPXTrackPoint) {
        self.init(
            latitude: gpxTrackPoint.coordinate.latitude,
            longitude: gpxTrackPoint.coordinate.longitude
        )
    }
}
