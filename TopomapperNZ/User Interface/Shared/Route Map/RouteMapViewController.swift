//
//  RouteMapViewController.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import UIKit
import MapKit

class RouteMapViewController: UIViewController {
    let route: Route
    let mapFrameHeight: CGFloat
    
    internal let mapView = MKMapView()
    
    // MARK: - Initializers
    init(route: Route, mapFrameHeight: CGFloat) {
        self.route = route
        self.mapFrameHeight = mapFrameHeight
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
        setupMapView()
        addTopo50Overlay()
        addRoutePolylines()
        addStartEndAnnotations()
        addStopAnnotations()
        
        self.view = mapView
    }
    
    // MARK: - Helper Functions
    /// Sets `MKMapView` properties such as the frame, controls shown, etc.
    internal func setupMapView() {
        mapView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.bounds.width - 20,
            height: mapFrameHeight
        )
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.overrideUserInterfaceStyle = .light
    }
    
    /// Adds the LINZ Topo50 `MKTileOverlay` to the map.
    internal func addTopo50Overlay() {
        let topo50Overlay = MKTileOverlay(urlTemplate: TileServerURLTemplate.topo50)
        
        topo50Overlay.canReplaceMapContent = false
        mapView.addOverlay(topo50Overlay, level: .aboveRoads)
    }
    
    /// Adds the polylines describing the given `Route`'s path to the map, and
    /// zooms in on the polylines with animation.
    internal func addRoutePolylines() {
        let polylines = route.polylines
        
        for polyline in polylines {
            mapView.addOverlay(polyline)
        }
        
        mapView
            .setVisibleMapRect(
                polylines.first!.boundingMapRect,
                edgePadding: .init(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )
    }
    
    /// Adds the `Route`'s start and end annotations to the map.
    internal func addStartEndAnnotations() {
        for annotation in route.startEndAnnotation {
            mapView.addAnnotation(annotation)
        }
    }
    
    /// Adds the `Route`'s stop annotations to the map.
    internal func addStopAnnotations() {
        for stop in route.stops {
            guard let day = stop.day else { continue }
            
            let stopAnnotation = StopAnnotation(
                coordinate: stop.coordinate,
                number: day
            )
            mapView.addAnnotation(stopAnnotation)
        }
    }
}
