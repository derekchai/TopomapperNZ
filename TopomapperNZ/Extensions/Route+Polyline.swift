//
//  Route+Polyline.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

extension Route {
    /// Returns the `MKPolyline` created from the points of this `Route`.
    var polyline: MKPolyline {
        let coordinates = self.points.map { $0.coordinate }
        
        return MKPolyline(
            coordinates: coordinates,
            count: self.points.count
        )
    }
}
