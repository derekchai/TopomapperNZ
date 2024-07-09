//
//  GPXTrackPoint+Distance.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension GPXTrackPoint {
    func distance(from gpxTrackPoint: GPXTrackPoint) -> CLLocationDistance {
        let clLocation1 = CLLocation(from: self)
        let clLocation2 = CLLocation(from: gpxTrackPoint)
        
        return clLocation2.distance(from: clLocation1)
    }
}
