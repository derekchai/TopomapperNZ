//
//  CLLocationCoordinate2D+Distance.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(
            latitude: self.latitude,
            longitude: self.longitude
        )
        
        let location2 = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        
        return location1.distance(from: location2)
    }
}
