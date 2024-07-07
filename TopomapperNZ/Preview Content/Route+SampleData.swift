//
//  Route+SampleData.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

extension Route {
    static var sampleData: [Route] {
        var routes = [Route]()
        let names = ["Route A", "Route B", "Route C", "Route D", "Route E"]
        
        for i in 0..<10 {
            let randomName = names.randomElement() ?? "Route \(i)"
            let randomDate = Date(timeIntervalSinceNow: -Double.random(in: 0...1000000))
            let route = Route(name: randomName, creationDate: randomDate)
            routes.append(route)
        }
        
        return routes
    }
}
