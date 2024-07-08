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
    let gpxParser = GPXParser()
    
    @Test("Test parsing GPX file")
    func testParsingGPXFile() throws {
        let bundle = Bundle(for: type(of: self))
        
        let gpxURL = try #require(
            bundle.url(forResource: "SampleGPX", withExtension: "gpx")
        )
        
        let locations = try gpxParser.parseFile(at: gpxURL)
        
        #expect(!locations.isEmpty)
    }
}

// MARK: - Errors
extension GPXParsingTests {
    enum TestError: Error {
        case unableToCreateURL
    }
}
