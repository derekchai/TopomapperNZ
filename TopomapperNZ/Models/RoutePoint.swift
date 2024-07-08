//
//  RoutePoint.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

class RoutePoint: Location {
    let distanceFromStart: CLLocationDistance
    let grade: Double
    
    // MARK: - Initializers
    init(
        coordinate: CLLocationCoordinate2D,
        elevation: CLLocationDistance,
        distanceFromStart: CLLocationDistance,
        grade: Double
    ) {
        self.distanceFromStart = distanceFromStart
        self.grade = grade
        
        super.init(coordinate: coordinate, elevation: elevation)
    }
    
    init(
        location: Location,
        distanceFromStart: CLLocationDistance,
        grade: Double
    ) {
        self.distanceFromStart = distanceFromStart
        self.grade = grade
        
        super.init(
            coordinate: location.coordinate,
            elevation: location.elevation
        )
    }

    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
