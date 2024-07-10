//
//  StartEndAnnotation.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

class StartEndAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pointType: PointType
    
    // MARK: - Initializer
    init(coordinate: CLLocationCoordinate2D, pointType: PointType) {
        self.coordinate = coordinate
        self.pointType = pointType
    }
    
    enum PointType {
        case start
        case end
    }
}
