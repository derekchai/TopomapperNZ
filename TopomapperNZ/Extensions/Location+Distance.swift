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
        let clLocation1 = CLLocation(from: self)
        let clLocation2 = CLLocation(from: location)
        
        return clLocation2.distance(from: clLocation1)
    }
}
