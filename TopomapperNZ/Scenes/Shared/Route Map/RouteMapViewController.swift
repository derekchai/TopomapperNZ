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
    
    private let mapView = MKMapView()
    private let topo50Overlay = MKTileOverlay(urlTemplate: TileServerURLTemplate.topo50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
        mapView.frame = self.view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.overrideUserInterfaceStyle = .light
        
        topo50Overlay.canReplaceMapContent = false
        
        mapView.addOverlay(topo50Overlay, level: .aboveRoads)

        self.view = mapView
    }

    init(route: Route) {
        self.route = route
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
