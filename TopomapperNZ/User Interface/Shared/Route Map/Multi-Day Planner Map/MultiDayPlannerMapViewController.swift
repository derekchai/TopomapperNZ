//
//  MultiDayPlannerMapViewController.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MultiDayPlannerMapViewController: RouteMapViewController {
    let coordinateRoutePointDictionary: [CLLocationCoordinate2D: RoutePoint]
    
    // MARK: - Initializer Overrides
    override init(route: Route, mapFrameHeight: CGFloat) {
        self.coordinateRoutePointDictionary = route.coordinateRoutePointDictionary
        
        super.init(route: route, mapFrameHeight: mapFrameHeight)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method Overrides
    override func loadView() {
        super.loadView()
        
        setupMapView()
        addTopo50Overlay()
        addRoutePolylines()
        addStartEndAnnotations()
        addTapGestureRecognizer()
        
        self.view = mapView
    }
    
    // MARK: - Helper Functions
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTapGesture)
        )
        
        mapView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        let tappedPoint: CGPoint = sender.location(in: mapView)
        let tappedCoordinate: CLLocationCoordinate2D = mapView.convert(
            tappedPoint,
            toCoordinateFrom: mapView
        )
        let tappedMapPoint: MKMapPoint = MKMapPoint(tappedCoordinate)
        
        let maximumMetersFromPoint: Double = mapView.distance(
            from: tappedPoint,
            byPixelsHorizontallyAcross: 22
        )
        
        var closestPointToTap: MKMapPoint?
        
        for overlay in mapView.overlays where overlay is MKPolyline {
            let polyline = overlay as! MKPolyline
            
            closestPointToTap = polyline.closestPointInPolyline(to: tappedMapPoint)
        }
        
        guard let closestPointToTap else { return }
        
        // Round the lat. and lon. of closestPointToTap to 6 d.p.
        let roundedClosestCoordinateToTap = CLLocationCoordinate2D(
            latitude: closestPointToTap.coordinate.latitude.rounded(toPlaces: 6),
            longitude: closestPointToTap.coordinate.longitude.rounded(toPlaces: 6)
        )
        
        let distanceAway = closestPointToTap.distance(to: tappedMapPoint)
        
        if distanceAway <= maximumMetersFromPoint {
            if let tappedRoutePoint = coordinateRoutePointDictionary[roundedClosestCoordinateToTap] {
                print(String(describing: tappedRoutePoint))
            }
        }
    }
}
