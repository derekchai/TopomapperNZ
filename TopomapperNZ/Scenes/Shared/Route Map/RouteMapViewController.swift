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
