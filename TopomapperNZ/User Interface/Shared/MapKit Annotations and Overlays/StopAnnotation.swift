//
//  RoutePointSelectionAnnotation.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import UIKit
import MapKit

class StopAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
