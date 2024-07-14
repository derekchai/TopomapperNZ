//
//  SectionHeader.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import SwiftUI

struct SectionHeader<Content: View>: View {
    let title: String
    @ViewBuilder let actions: () -> Content
    
    // MARK: - Initializer
    init(
        title: String,
        @ViewBuilder actions: @escaping () -> Content = {
            EmptyView()
        }
    ) {
        self.title = title
        self.actions = actions
    }

    // MARK: - Body
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
