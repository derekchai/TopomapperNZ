//
//  [RoutePoint]+Metrics.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import CoreLocation

extension Array where Element == RoutePoint {
    /// Uses a modified binary search to find the `RoutePoint` in this array whose
    /// `distanceFromStart` property is closest to the `distanceFromStart` given.
    func nearestPoint(to distanceFromStart: Double) -> RoutePoint? {
        guard !self.isEmpty else { return nil }
        
        if distanceFromStart < self.first!.distanceFromStart {
            return self.first!
        }
        
        if distanceFromStart > self.last!.distanceFromStart {
            return self.last!
        }
        
        var low: Int = 0
        var high: Int = self.count - 1
        
        while low <= high {
            let mid: Int = (low + high) / 2
            let midPoint = self[mid]
            
            if midPoint.distanceFromStart == distanceFromStart {
                return midPoint
            } else if midPoint.distanceFromStart < distanceFromStart {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        
        let lowerBoundPoint = self[Swift.max(low - 1, 0)]
        let upperBoundPoint = self[Swift.min(low, self.count - 1)]
        
        if abs(lowerBoundPoint.distanceFromStart - distanceFromStart) < abs(
            upperBoundPoint
                .distanceFromStart - distanceFromStart) {
            return lowerBoundPoint
        } else {
            return upperBoundPoint
        }
    }
    
    /// Returns the total length of the `Route` (in meters).
    var length: CLLocationDistance {
        guard let lastPoint = self.last else { return 0 }
        
        return lastPoint.distanceFromStart
    }
    
    /// Returns the cumulative elevation gain of the `Route` (in meters).
    var cumulativeElevationGain: CLLocationDistance {
        guard self.count > 1 else { return 0 }
        
        var cumulativeElevationGain: CLLocationDistance = 0
        
        for i in 1..<self.count {
            let elevationChange = self[i].elevation - self[i - 1].elevation
            
            if elevationChange > 0 {
                cumulativeElevationGain += elevationChange
            }
        }
        
        return cumulativeElevationGain
    }
    
    /// Returns the cumulative elevation loss of the `Route` (in meters).
    var cumulativeElevationLoss: CLLocationDistance {
        guard self.count > 1 else { return 0 }
        
        var cumulativeElevationLoss: CLLocationDistance = 0
        
        for i in 1..<self.count {
            let elevationChange = self[i].elevation - self[i - 1].elevation
            
            if elevationChange < 0 {
                cumulativeElevationLoss += abs(elevationChange)
            }
        }
        
        return cumulativeElevationLoss
    }
    
    /// Returns the maximum elevation (highest point) on the `Route` (in meters).
    var maximumElevation: CLLocationDistance? {
        guard !self.isEmpty else { return nil }
        
        return self.max { $0.elevation < $1.elevation }!.elevation
    }
    
    /// Returns the minimum elevation (lowest point) on the `Route` (in meters).
    var minimumElevation: CLLocationDistance? {
        guard !self.isEmpty else { return nil }
        
        return self.max { $0.elevation > $1.elevation }!.elevation
    }
}
