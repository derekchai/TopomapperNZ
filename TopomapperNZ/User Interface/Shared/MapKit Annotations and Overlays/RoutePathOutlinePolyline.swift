//
//  RoutePathOutlinePolyline.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import UIKit
import MapKit

class RoutePathOutlinePolyline: MKPolyline, RoutePathRepresentable {
    var renderer: MKPolylineRenderer {
        let renderer = MKPolylineRenderer(polyline: self)
        
        renderer.strokeColor = .routePathOutline
        renderer.lineWidth = 6
        renderer.lineCap = .round
        renderer.lineJoin = .round
        
        return renderer
    }
}
