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

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.distanceFromStart = try container.decode(CLLocationDistance.self, forKey: .distanceFromStart)
        self.grade = try container.decode(Double.self, forKey: .grade)
        
        // Decode the properties of the superclass Location
        try super.init(from: decoder)
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case distanceFromStart
        case grade
    }
}
