//
//  Route+Annotations&Overlays.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

extension Route {
    /// Returns the main and outline polylines created from the points of this
    /// `Route`.
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
        
        return [outlinePolyline, pathPolyline]
    }
    
    /// Returns the start and end `StartEndAnnotation`s for this `Route`.
    var startEndAnnotation: [StartEndAnnotation] {
        guard !self.points.isEmpty else { return [] }
        
        let startAnnotation = StartEndAnnotation(
            coordinate: self.points.first!.coordinate,
            pointType: .start
        )
        
        let endAnnotation = StartEndAnnotation(
            coordinate: self.points.last!.coordinate,
            pointType: .end
        )
        
        return [startAnnotation, endAnnotation]
    }
}
