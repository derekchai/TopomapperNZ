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
        let clLocation1 = CLLocation(
            latitude: self.coordinate.latitude,
            longitude: self.coordinate.longitude
        )
        
        let clLocation2 = CLLocation(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        return clLocation2.distance(from: clLocation1)
    }
}
