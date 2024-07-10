//
//  SectionHeader.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import SwiftUI

struct SectionHeader<Content: View>: View {
    let title: String
    @ViewBuilder var actions: () -> Content

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            
            Spacer()
            
            actions()
        }
    }
}

#Preview {
    SectionHeader(title: "My Section") {
        Button("Press") {}
    }
}
