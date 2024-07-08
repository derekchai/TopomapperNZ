//
//  NewRouteSheet+Actions.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

extension NewRouteSheet {
    func dismissSheet() {
        dismiss()
    }
    
    func dismissErrorAlert() {
        self.didError = false
    }
    
    func presentFileImporter() {
        self.isPresentingFileImporter = true
    }
    
    func handleFileImporterResult(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            
            let gotAccess = url.startAccessingSecurityScopedResource()
            
            guard gotAccess else { return }
            
            selectedFileURL = url
            selectedFileName = url.lastPathComponent
            
            url.stopAccessingSecurityScopedResource()
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    func saveRoute() {
        guard let selectedFileURL else {
            showErrorAlert(title: "This file could not be opened")
            return
        }
        
        isProcessingGPXFile = true
        
        let gpxParser = GPXParser()
        
        do {
            let locations: [Location] = try gpxParser.parsed(at: selectedFileURL)
            
            let route = Route(
                name: routeName,
                creationDate: Date(),
                points: [RoutePoint].init(from: locations)
            )
            
            modelContext.insert(route)
        } catch {
            showErrorAlert(for: error, title: "This file could not be processed")
        }
        
        isProcessingGPXFile = false
        dismiss()
    }
    
    // MARK: - Private Functions
    private func showErrorAlert(for error: Error? = nil, title: String) {
        self.didError = true
        self.error = error
        self.errorAlertTitle = title
    }
}
