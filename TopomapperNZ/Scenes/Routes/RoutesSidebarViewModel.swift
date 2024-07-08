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
        private(set) var isPresentingFileImporter = false
        
        private(set) var routes = Route.sampleData
        
        var isPresentingFileImporterBinding: Binding<Bool> {
            Binding(
                get: { self.isPresentingFileImporter },
                set: { newValue in
                    self.isPresentingFileImporter = newValue
                }
            )
        }
        
        // MARK: - Functions
        func presentFileImporter() {
            isPresentingFileImporter = true
        }
        
        func handleFileImporterResult(_ result: Result<[URL], Error>) {
            switch result {
            case .success(let urls):
                for url in urls {
                    let gotAccess = url.startAccessingSecurityScopedResource()
                    
                    guard gotAccess else { return }
                    
                    url.stopAccessingSecurityScopedResource()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
