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
    
    private let mapView = MKMapView()
    private let topo50Overlay = MKTileOverlay(urlTemplate: TileServerURLTemplate.topo50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
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
        
        // Topo50 overlay
        topo50Overlay.canReplaceMapContent = false
        mapView.addOverlay(topo50Overlay, level: .aboveRoads)
        
        let polylines = route.polylines
        
        // Polyline overlays
        for polyline in polylines {
            mapView.addOverlay(polyline)
        }
        
        mapView
            .setVisibleMapRect(
                polylines.first!.boundingMapRect,
                edgePadding: .init(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )

        self.view = mapView
    }

    init(route: Route, mapFrameHeight: CGFloat) {
        self.route = route
        self.mapFrameHeight = mapFrameHeight
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
