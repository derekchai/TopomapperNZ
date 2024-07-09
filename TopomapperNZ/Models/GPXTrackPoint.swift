//
//  GPXTrackPoint.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

class GPXTrackPoint: Codable {
    let coordinate: CLLocationCoordinate2D
    let elevation: CLLocationDistance
    
    // MARK: - Initializer
    init(coordinate: CLLocationCoordinate2D, elevation: CLLocationDistance) {
        self.coordinate = coordinate
        self.elevation = elevation
    }
}
