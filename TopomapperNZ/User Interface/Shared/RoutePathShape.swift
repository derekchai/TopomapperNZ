//
//  RoutePathShape.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import SwiftUI

struct RoutePathShape: Shape {
    let route: Route
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let points = convertToCGPoints(in: rect)
        guard points.count > 1 else { return path }
        
        path.move(to: points[0])
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        
        return path
    }
    
    private func convertToCGPoints(in rect: CGRect) -> [CGPoint] {
        let points = route.points
        
        let longitudes = points.map { $0.coordinate.longitude }
        let latitudes = points.map { $0.coordinate.latitude }
        
        let minLon = longitudes.min() ?? 0
        let maxLon = longitudes.max() ?? 0
        
        let minLat = latitudes.min() ?? 0
        let maxLat = latitudes.max() ?? 0
        
        let xScaleFactor = rect.width / CGFloat(maxLon - minLon)
        let yScaleFactor = rect.width / CGFloat(maxLat - minLat)
        
        let scaleFactor = min(xScaleFactor, yScaleFactor)
        
        let xOffset = (rect.width - (CGFloat(maxLon - minLon) * scaleFactor)) / 2
        let yOffset = (rect.height - (CGFloat(maxLat - minLat) * scaleFactor)) / 2
        
        return points.map { point in
            let x = (CGFloat(point.coordinate.longitude) - CGFloat(minLon)) * scaleFactor + xOffset
            let y = rect.height - ((CGFloat(point.coordinate.latitude) - CGFloat(minLat)) * scaleFactor + yOffset)
            return CGPoint(x: x, y: y)
        }
    }
}
