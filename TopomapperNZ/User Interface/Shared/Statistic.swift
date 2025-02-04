//
//  Statistic.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct Statistic: View {
    let label: String
    let systemImageName: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
            
            HStack {
                Image(systemName: systemImageName)
                    .foregroundStyle(.secondary)
                
                Text(value)
            }
        }
    }
}


// MARK: - Preview

#Preview {
    Statistic(label: "Length", systemImageName: "point.topleft.down.to.point.bottomright.curvepath.fill", value: "74 km")
}
