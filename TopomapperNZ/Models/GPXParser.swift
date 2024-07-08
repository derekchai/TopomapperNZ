//
//  GPXParser.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation
import CoreLocation

final class GPXParser: NSObject, XMLParserDelegate {
    private var locations: [Location] = []
    private var currentElement: String = ""
    private var currentLocation: Location?
    private var temporaryCoordinate: CLLocationCoordinate2D?
    
    // MARK: - Functions
    func parsed(at url: URL) throws(ParsingError) -> [Location] {
        guard let xmlParser = XMLParser(contentsOf: url) else {
            throw .unableToCreateXMLParser
        }
        
        xmlParser.delegate = self
        
        let didSuccessfullyParse = xmlParser.parse()
        
        guard didSuccessfullyParse else {
            throw .failedToParseGPXFile
        }
        
        return locations
    }
    
    // MARK: - Delegate Methods
    
    // MARK: didStartElement
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        currentElement = elementName
        
        guard currentElement == "trkpt" else { return }
        
        guard let latitudeString = attributeDict["lat"],
              let longitudeString = attributeDict["lon"] else { return }
        
        guard let latitude = Double(latitudeString),
              let longitude = Double(longitudeString) else { return }
        
        temporaryCoordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    // MARK: foundCharacters
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard currentElement == "ele" else { return }
        
        guard let elevation = Double(
            string.trimmingCharacters(in: .whitespacesAndNewlines)
        ) else { return }
        
        guard let temporaryCoordinate else { return }
        
        currentLocation = Location(
            coordinate: temporaryCoordinate,
            elevation: elevation
        )
    }
    
    // MARK: didEndElement
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        guard elementName == "trkpt" else { return }
        
        guard let currentLocation else { return }
        
        locations.append(currentLocation)
    }
}

extension GPXParser {
    enum ParsingError: Error {
        case unableToCreateXMLParser
        case failedToParseGPXFile
    }
}
