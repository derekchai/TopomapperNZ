//
//  RoutePointsStatistics.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 14/07/2024.
//

import SwiftUI

struct RoutePointsStatistics: View {
    let points: [RoutePoint]
    
    var body: some View {
        HStack {
            Statistic(
                label: "Length",
                systemImageName: Symbol.distance,
                value: points.length.formatted(.routeLength)
            )
            Divider()
            Statistic(
                label: "Alt. Gain",
                systemImageName: Symbol.elevationGain,
                value: points.cumulativeElevationGain
                    .formatted(.elevation)
            )
            Divider()
            Statistic(
                label: "Alt. Loss",
                systemImageName: Symbol.elevationLoss,
                value: points.cumulativeElevationLoss
                    .formatted(.elevation)
            )
        }
    }
}

#Preview {
    RoutePointsStatistics(points: Route.sampleData.first!.points)
}
