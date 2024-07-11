//
//  GPXTrackPoint+Distance.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension GPXTrackPoint {
    /// Calculates the distance in meters from the given `GPXTrackPpoint`, taking into
    /// account the curvature of the Earth.
    /// - Parameter gpxTrackPoint: The point to calculate the distance from.
    /// - Returns: The distance between the two points, in meters.
    func distance(from gpxTrackPoint: GPXTrackPoint) -> CLLocationDistance {
        let clLocation1 = CLLocation(from: self)
        let clLocation2 = CLLocation(from: gpxTrackPoint)
        
        return clLocation2.distance(from: clLocation1)
    }
}
