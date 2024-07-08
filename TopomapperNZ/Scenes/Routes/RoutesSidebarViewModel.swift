//
//  RoutesSidebarViewModel.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import SwiftUI

extension RoutesSidebar {
    @Observable
    class ViewModel {
        var isPresentingFileImporter = false
        
        private(set) var routes = Route.sampleData
        
        // MARK: - Functions
        func presentFileImporter() {
            isPresentingFileImporter = true
        }
        
        func handleFileImporterResult(_ result: Result<[URL], Error>) {
            switch result {
            case .success(let urls):
                guard let url = urls.first else { return }
                
                let gotAccess = url.startAccessingSecurityScopedResource()
                
                guard gotAccess else { return }
                
                let gpxParser = GPXParser()
                
                var locations = [Location]()
                
                do {
                    locations = try gpxParser.parseFile(at: url)
                } catch {
                    print(error)
                }
                
                print(locations)
                
                url.stopAccessingSecurityScopedResource()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
