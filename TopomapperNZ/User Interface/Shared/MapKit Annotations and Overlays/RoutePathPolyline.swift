//
//  RoutePathPolyline.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import UIKit
import MapKit

class RoutePathPolyline: MKPolyline, RoutePathRepresentable {
    var renderer: MKPolylineRenderer {
        let renderer = MKPolylineRenderer(polyline: self)
        
        renderer.strokeColor = .systemBlue
        renderer.lineWidth = 3
        renderer.lineCap = .round
        renderer.lineJoin = .round
        
        return renderer
    }
}
