//
//  Route+CoordinateRoutePointDictionary.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import CoreLocation

extension Route {
    /// Returns a dictionary of `CLLocationCoordinate2D` keys to `RoutePoint`
    /// values.
    ///
    /// This can facilitate efficient dictionary lookups.
    var coordinateRoutePointDictionary: [CLLocationCoordinate2D: RoutePoint] {
        var output = [CLLocationCoordinate2D: RoutePoint]()
        
        for point in self.points {
            output[point.coordinate] = point
        }
        
        return output
    }
}
