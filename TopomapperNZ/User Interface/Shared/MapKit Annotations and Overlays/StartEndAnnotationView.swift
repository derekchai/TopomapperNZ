//
//  StartAnnotationView.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import MapKit

class StartEndAnnotationView: MKAnnotationView {
    
    // MARK: - Initializers
    override init(annotation: (any MKAnnotation)?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        canShowCallout = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Property Overrides
    override var annotation: (any MKAnnotation)? {
        didSet {
            updateAnnotation(for: annotation)
        }
    }
    
    // MARK: - Private Functions
    private func updateAnnotation(for annotation: MKAnnotation?) {
        guard let annotation = annotation as? StartEndAnnotation else { return }
        
        let systemImageName: String
        
        switch annotation.pointType {
        case .start:
            systemImageName = Symbol.startPoint
        case .end:
            systemImageName = Symbol.endPoint
        }
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        
        let mainColorsConfiguration = UIImage.SymbolConfiguration(
            paletteColors: [.white, .systemBlue]
        )
        
        var mainImage = UIImage(
            systemName: systemImageName,
            withConfiguration: symbolConfiguration
        )
        mainImage = mainImage?
            .applyingSymbolConfiguration(mainColorsConfiguration)
        
        mainImage = mainImage?.withRenderingMode(.alwaysOriginal)
        
        let outlineConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        var outlineImage = UIImage(
            systemName: systemImageName,
            withConfiguration: outlineConfiguration
        )
        outlineImage = outlineImage?.withRenderingMode(.alwaysTemplate)
        
        let outlineImageView = UIImageView(image: outlineImage)
        outlineImageView.tintColor = .routePathOutline
        
        let mainImageView = UIImageView(image: mainImage)
        
        // Centering mainImageView atop outlineImageView.
        outlineImageView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        mainImageView.frame = CGRect(x: 2, y: 2, width: 18, height: 18)
        
        let containerView = UIView()
        containerView.addSubview(outlineImageView)
        containerView.addSubview(mainImageView)
        containerView.frame = outlineImageView.frame
        
        self.addSubview(containerView)
        self.bounds = containerView.bounds
    }
}
