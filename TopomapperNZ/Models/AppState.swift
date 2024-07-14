//
//  AppState.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 15/07/2024.
//

import Foundation

@Observable
class AppState {
    @Observable
    class Navigation {
        var selectedRoute: Route?
    }
}
