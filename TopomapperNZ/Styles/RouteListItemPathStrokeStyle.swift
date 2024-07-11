//
//  RouteListItemPathStrokeStyle.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation
import SwiftUICore

private let routeListItemPathStrokeStyle = StrokeStyle(
    lineWidth: 2,
    lineCap: .round,
    lineJoin: .round
)

extension StrokeStyle {
    /// A stroke style for the path of a Route within a `RouteListItem`.
    static let routeListItemPath = routeListItemPathStrokeStyle
}
