//
//  TopomapperNZTests.swift
//  TopomapperNZTests
//
//  Created by Derek Chai on 08/07/2024.
//

import Testing
import Foundation
@testable import TopomapperNZ

struct TopomapperNZTests {
    @Test func testGPXParser() throws {
        let gpxURL = Bundle.main.url(forResource: "SampleGPX", withExtension: "gpx")
        
        #expect(gpxURL != nil)
        
        let gpxParser = GPXParser()
            
        let locations = try gpxParser.parseFile(at: gpxURL!)
        
        print(locations)
    }
}
