//
//  ContentView.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Routes", systemImage: "point.topleft.down.to.point.bottomright.curvepath") {
                
            }
            
            Tab("Map", systemImage: "map") {
                
            }
            
            Tab("Profile", systemImage: "person.crop.circle") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
