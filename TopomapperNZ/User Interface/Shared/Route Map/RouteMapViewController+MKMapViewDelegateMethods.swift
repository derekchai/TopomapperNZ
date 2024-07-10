//
//  RouteMapViewController+MKMapViewDelegateMethods.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

extension RouteMapViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        rendererFor overlay: any MKOverlay
    ) -> MKOverlayRenderer {
        switch overlay {
        case let tileOverlay as MKTileOverlay:
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        case let mainPolylineOverlay as RoutePathPolyline:
            return mainPolylineOverlay.renderer
        case let outlinePolylineOverlay as RoutePathOutlinePolyline:
            return outlinePolylineOverlay.renderer
        default:
            fatalError("Unhandled overlay type: \(overlay).")
        }
    }
}
