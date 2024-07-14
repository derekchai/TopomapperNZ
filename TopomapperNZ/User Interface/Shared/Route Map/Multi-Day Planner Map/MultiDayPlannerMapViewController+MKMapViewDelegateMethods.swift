//
//  MultiDayPlannerMapViewController+MKMapViewDelegateMethods.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import MapKit

extension MultiDayPlannerMapViewController {
    override func mapView(
        _ mapView: MKMapView,
        viewFor annotation: any MKAnnotation
    ) -> MKAnnotationView? {
        let identifier = String(describing: annotation.self)
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            return dequeuedView
        }
        
        switch annotation {
        case let startEndAnnotation as StartEndAnnotation:
            return StartEndAnnotationView(
                annotation: startEndAnnotation,
                reuseIdentifier: identifier
            )
            
        case let routePointSelectionAnnotation as StopAnnotation:
            let marker = MKMarkerAnnotationView(
                annotation: routePointSelectionAnnotation,
                reuseIdentifier: identifier
            )
            
            marker.animatesWhenAdded = true
            marker.canShowCallout = false
            
            return marker
            
        default:
            fatalError("Unhandled annotation type: \(annotation).")
        }
    }
}
