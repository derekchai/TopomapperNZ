//
//  MultiDayPlannerMapViewControllerRepresentable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import UIKit
import SwiftUI

struct MultiDayPlannerMapViewControllerRepresentable: UIViewControllerRepresentable, MultiDayPlannerMapViewController.Delegate {
    @Binding var stops: [RoutePoint]
    
    let route: Route
    let mapFrameHeight: CGFloat
    let onUpdateSelectedRoutePoint: (RoutePoint?) -> Void
    
    // MARK: - UIViewControllerRepresentable Protocol Methods
    func makeUIViewController(context: Context) -> MultiDayPlannerMapViewController {
        MultiDayPlannerMapViewController(
            route: route,
            mapFrameHeight: mapFrameHeight,
            delegate: self
        )
    }
    
    func updateUIViewController(
        _ uiViewController: MultiDayPlannerMapViewController,
        context: Context
    ) {
        uiViewController.updateStops(to: stops)
    }
    
    // MARK: - MultiDayPlannerMapViewControllerDelegate Methods
    func didUpdateSelectedRoutePoint(to newRoutePoint: RoutePoint?) {
        onUpdateSelectedRoutePoint(newRoutePoint)
    }
}
