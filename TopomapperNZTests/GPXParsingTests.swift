//
//  TopomapperNZTests.swift
//  TopomapperNZTests
//
//  Created by Derek Chai on 08/07/2024.
//

import Testing
import Foundation
@testable import TopomapperNZ

@Suite("GPX parsing tests")
final class GPXParsingTests {
    @Test("Test parsing GPX file")
    func testParsingGPXFile() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let gpxURL = bundle.url(forResource: "SampleGPX", withExtension: "gpx") else {
            throw TestError.unableToCreateURL
        }
        
        #expect(gpxURL != nil)
        
        let gpxParser = GPXParser()
            
        let locations = try gpxParser.parseFile(at: gpxURL)
        
        #expect(!locations.isEmpty)
    }
    
    enum TestError: Error {
        case unableToCreateURL
    }
}
