//
//  [RoutePoint]+Initializers.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

extension [RoutePoint] {
    init(from locations: [Location]) {
        var distanceFromStart: CLLocationDistance = 0
        
        var previousLocation: Location? = nil
        
        var output: [RoutePoint] = []
        
        for location in locations {
            guard let previousLocation else {
                let routePoint = RoutePoint(
                    coordinate: location.coordinate,
                    elevation: location.elevation,
                    distanceFromStart: 0,
                    grade: 0
                )
                
                output.append(routePoint)
                
                previousLocation = location
                
                continue
            }
            
            let distanceFromPreviousLocation = location.distance(from: previousLocation)
            let elevationChangeFromPreviousLocation = location.elevation - previousLocation.elevation
            
            distanceFromStart += distanceFromPreviousLocation
            
            let grade: Double
            
            if distanceFromPreviousLocation > 0 {
                grade = elevationChangeFromPreviousLocation / distanceFromPreviousLocation
            } else {
                grade = 0
            }
            
            let routePoint = RoutePoint(
                coordinate: location.coordinate,
                elevation: location.elevation,
                distanceFromStart: distanceFromStart,
                grade: grade
            )
            
            output.append(routePoint)
        }
        
        self.init(output)
    }
}
