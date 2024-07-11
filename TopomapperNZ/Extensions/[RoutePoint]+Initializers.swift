//
//  [RoutePoint]+Initializers.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension [RoutePoint] {
    /// Initializes an array of `RoutePoint`s from an array of `GPXTrackPoint`s.
    ///
    /// This initializer calculates the distance from start and grade for each
    /// given `GPXTrackPoint`.
    /// - Parameter gpxTrackPoints: The array of `GPXTrackPoints` to be converted.
    init(from gpxTrackPoints: [GPXTrackPoint]) {
        var distanceFromStart: CLLocationDistance = 0
        
        var previousTrackPoint: GPXTrackPoint? = nil
        
        var output: [RoutePoint] = []
        
        for trackPoint in gpxTrackPoints {
            guard previousTrackPoint != nil else {
                let routePoint = RoutePoint(
                    coordinate: trackPoint.coordinate,
                    elevation: trackPoint.elevation,
                    distanceFromStart: 0,
                    grade: 0
                )
                
                output.append(routePoint)
                
                previousTrackPoint = trackPoint
                
                continue
            }
            
            let distanceFromPreviousTrackPoint = trackPoint.distance(
                from: previousTrackPoint!
            )
            
            let elevationChangeFromPreviousTrackPoint = trackPoint.elevation - previousTrackPoint!.elevation
            
            distanceFromStart += distanceFromPreviousTrackPoint
            
            let grade: Double
            
            if distanceFromPreviousTrackPoint > 0 {
                grade = elevationChangeFromPreviousTrackPoint / distanceFromPreviousTrackPoint
            } else {
                grade = 0
            }
            
            let routePoint = RoutePoint(
                coordinate: trackPoint.coordinate,
                elevation: trackPoint.elevation,
                distanceFromStart: distanceFromStart,
                grade: grade
            )
            
            output.append(routePoint)
            
            previousTrackPoint = trackPoint
        }
        
        self.init(output)
    }
}
