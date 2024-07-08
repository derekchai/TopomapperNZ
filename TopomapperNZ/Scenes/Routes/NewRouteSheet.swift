//
//  NewRouteSheet.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import SwiftUI

struct NewRouteSheet: View {
    @Environment(\.modelContext) internal var modelContext
    @Environment(\.dismiss) internal var dismiss
    
    @State internal var routeName: String = ""
    
    @State internal var selectedFileName: String? = nil
    @State internal var selectedFileURL: URL? = nil
    
    @State internal var isPresentingFileImporter = false
    @State internal var isPresentingNewRouteSheet = false
    
    @State internal var isProcessingGPXFile = false
    
    @State internal var didError = false
    @State internal var error: Error? = nil
    @State internal var errorAlertTitle = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if isProcessingGPXFile {
                    ProgressView("Processing file...")
                } else {
                    Form {
                        TextField("Route name", text: $routeName)
                        
                        HStack {
                            Text("GPX file")
                            
                            Spacer()
                            
                            if let selectedFileName = selectedFileName {
                                Button(selectedFileName, action: presentFileImporter)
                            } else {
                                Button("Import from Files", action: presentFileImporter)
                            }
                        }
                    } // Form
                }
            }
            .navigationTitle("New Route")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: dismissSheet)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveRoute)
                        .disabled(routeName.isEmpty || selectedFileURL == nil)
                }
            }
        } // NavigationStack
        .fileImporter(
            isPresented: $isPresentingFileImporter,
            allowedContentTypes: [.xml],
            allowsMultipleSelection: false,
            onCompletion: handleFileImporterResult,
            onCancellation: {}
        )
        .alert(
            errorAlertTitle,
            isPresented: $didError,
            presenting: error
        ) { _ in
            Button("Ok", action: dismissErrorAlert)
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    NewRouteSheet()
}
