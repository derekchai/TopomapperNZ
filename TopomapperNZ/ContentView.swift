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
            Tab("Routes", systemImage: Symbol.path) {
                RoutesScene()
            }
            
            Tab("Map", systemImage: Symbol.map) {
                
            }
            
            Tab("Profile", systemImage: Symbol.profile) {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
