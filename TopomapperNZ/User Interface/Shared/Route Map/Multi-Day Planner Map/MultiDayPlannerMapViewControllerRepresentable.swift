//
//  MultiDayPlannerMapViewControllerRepresentable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import UIKit
import SwiftUI

struct MultiDayPlannerMapViewControllerRepresentable: UIViewControllerRepresentable {
    let route: Route
    let mapFrameHeight: CGFloat
    
    func makeUIViewController(context: Context) -> MultiDayPlannerMapViewController {
        MultiDayPlannerMapViewController(
            route: route,
            mapFrameHeight: mapFrameHeight
        )
    }
    
    func updateUIViewController(
        _ uiViewController: MultiDayPlannerMapViewController,
        context: Context
    ) {
        // Update code goes here.
    }
}
