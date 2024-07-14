//
//  RoutePoint.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

class RoutePoint: Codable, Identifiable {
    let coordinate: CLLocationCoordinate2D
    let elevation: CLLocationDistance
    let distanceFromStart: CLLocationDistance
    let grade: Double
    var day: Int?
    
    init(
        coordinate: CLLocationCoordinate2D,
        elevation: CLLocationDistance,
        distanceFromStart: CLLocationDistance,
        grade: Double,
        day: Int?
    ) {
        self.coordinate = coordinate
        self.elevation = elevation
        self.distanceFromStart = distanceFromStart
        self.grade = grade
        self.day = day
    }
}
