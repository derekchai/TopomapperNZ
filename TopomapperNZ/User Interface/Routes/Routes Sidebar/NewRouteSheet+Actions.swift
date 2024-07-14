//
//  NewRouteSheet+Actions.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

extension NewRouteSheet {
    /// Dismisses this sheet.
    func dismissSheet() {
        dismiss()
    }
    
    /// Dismisses the error alert.
    func dismissErrorAlert() {
        self.didError = false
    }
    
    /// Presents the file importer interface.
    func presentFileImporter() {
        self.isPresentingFileImporter = true
    }
    
    /// Handles the result of the file importer.
    ///
    /// If the result is successful, getes the selected file's URL and its last
    /// path component. If the result fails, prints the error.
    /// - Parameter result: The result from the file importer.
    func handleFileImporterResult(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            
            let gotAccess = url.startAccessingSecurityScopedResource()
            
            guard gotAccess else {
                url.stopAccessingSecurityScopedResource()
                return
            }
            
            selectedFileURL = url
            selectedFileName = url.lastPathComponent
            
            url.stopAccessingSecurityScopedResource()
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    /// Parses the GPX file URL and creates a new `Route`, inserting it into
    /// the `modelContext`.
    func saveRoute() {
        guard let selectedFileURL else {
            showErrorAlert(title: "This file could not be opened")
            return
        }
        
        isProcessingGPXFile = true
        
        let gpxParser = GPXParser()
        
        let gotAccess = selectedFileURL.startAccessingSecurityScopedResource()
        
        guard gotAccess else {
            showErrorAlert(title: "Topomapper has insufficient permissions to access this file")
            selectedFileURL.stopAccessingSecurityScopedResource()
            return
        }
        
        let gpxTrackPoints: [GPXTrackPoint]
        
        do {
            gpxTrackPoints = try gpxParser.parsed(at: selectedFileURL)
        } catch {
            showErrorAlert(for: error, title: "This file could not be processed")
            selectedFileURL.stopAccessingSecurityScopedResource()
            return
        }
        
        let route = Route(
            name: routeName,
            creationDate: Date(),
            points: [RoutePoint].init(from: gpxTrackPoints)
        )
        
        modelContext.insert(route)
        
        selectedFileURL.stopAccessingSecurityScopedResource()
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
