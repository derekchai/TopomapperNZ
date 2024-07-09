//
//  Route+Metrics.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import Foundation
import CoreLocation

extension Route {
    /// Returns the total length of the `Route` (in meters).
    var length: CLLocationDistance {
        guard let lastPoint = self.points.last else { return 0 }
        
        return lastPoint.distanceFromStart
    }
    
    /// Returns the cumulative elevation gain of the `Route` (in meters).
    var cumulativeElevationGain: CLLocationDistance {
        guard self.points.count > 1 else { return 0 }
        
        var cumulativeElevationGain: CLLocationDistance = 0
        
        for i in 1..<self.points.count {
            let elevationChange = points[i].elevation - points[i - 1].elevation
            
            if elevationChange > 0 {
                cumulativeElevationGain += elevationChange
            }
        }
        
        return cumulativeElevationGain
    }
    
    /// Returns the cumulative elevation loss of the `Route` (in meters).
    var cumulativeElevationLoss: CLLocationDistance {
        guard self.points.count > 1 else { return 0 }
        
        var cumulativeElevationLoss: CLLocationDistance = 0
        
        for i in 1..<self.points.count {
            let elevationChange = points[i].elevation - points[i - 1].elevation
            
            if elevationChange < 0 {
                cumulativeElevationLoss += abs(elevationChange)
            }
        }
        
        return cumulativeElevationLoss
    }
    
    /// Returns the maximum elevation (highest point) on the `Route` (in meters).
    var maximumElevation: CLLocationDistance? {
        guard !points.isEmpty else { return nil }
        
        return self.points.max { $0.elevation < $1.elevation }!.elevation
    }
    
    /// Returns the minimum elevation (lowest point) on the `Route` (in meters).
    var minimumElevation: CLLocationDistance? {
        guard !points.isEmpty else { return nil }
        
        return self.points.max { $0.elevation > $1.elevation }!.elevation
    }
}
