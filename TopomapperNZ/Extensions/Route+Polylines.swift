//
//  Route+Polylines.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

extension Route {
    /// Returns the `MKPolyline` created from the points of this `Route`.
    var polylines: [any RoutePathRepresentable] {
        let coordinates = self.points.map { $0.coordinate }
        
        let pathPolyline = RoutePathPolyline(
            coordinates: coordinates,
            count: self.points.count
        )
        
        let outlinePolyline = RoutePathOutlinePolyline(
            coordinates: coordinates,
            count: self.points.count
        )
        
        return [pathPolyline, outlinePolyline]
    }
}
