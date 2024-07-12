//
//  MKPolyline+ClosestPointInPolylineToPoint.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import MapKit

extension MKPolyline {
    /// Returns the closest `MKMapPoint` in the given `MKPolyline` to the given
    /// `MKMapPoint`.
    /// - Parameter point: The `MKMapPoint` to find the closest point in the
    /// polyline to.
    /// - Returns: The closest point to `point`.
    func closestPointInPolyline(to point: MKMapPoint) -> MKMapPoint? {
        guard self.pointCount > 0 else { return nil }
        
        let points = self.points()
        
        var closestPoint = points[0]
        var minimumDistance = closestPoint.distance(to: point)
        
        for i in 1..<self.pointCount {
            let currentPoint = points[i]
            let distance = currentPoint.distance(to: point)
            
            if distance < minimumDistance {
                closestPoint = currentPoint
                minimumDistance = distance
            }
        }
        
        return closestPoint
    }
}
