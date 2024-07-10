//
//  RouteMapViewControllerRepresentable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import UIKit
import SwiftUI

struct RouteMapViewControllerRepresentable: UIViewControllerRepresentable {
    let route: Route
    let mapFrameHeight: CGFloat
    
    func makeUIViewController(context: Context) -> RouteMapViewController {
        RouteMapViewController(
            route: route,
            mapFrameHeight: mapFrameHeight
        )
    }

    func updateUIViewController(
        _ uiViewController: RouteMapViewController,
        context: Context
    ) {
        // Update code goes here.
    }
}
