//
//  Route+Helpers.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 09/07/2024.
//

import Foundation

extension Route {
    /// Renames the `Route` to the given new name.
    /// - Parameter newName: The name to rename the `Route` to.
    func rename(to newName: String) {
        self.name = newName
    }
    
    /// Sets the `day` property of a `RoutePoint` in this `Route`'s `points`
    /// property to the given `day`.
    /// - Parameters:
    ///   - index: The index which the `RoutePoint` is located within `points`.
    ///   - day: The new value of `day`.
    func setDay(at index: Int, to day: Int?) {
        self.points[index].day = day
    }
    
    func setPoints(to newPoints: [RoutePoint]) {
        self.points = newPoints
    }
    
    /// Returns a dictionary where the key is the day (`Int`) of the `RoutePoint`
    /// and the value (`[RoutePoint]`) is an array of `RoutePoint`s in this
    /// `Route` which share the same `day`.
    var pointsByDays: [Int: [RoutePoint]] {
        var output = [Int: [RoutePoint]]()
        
        for point in self.points {
            guard let day = point.day else { continue }
            
            if output[day] != nil {
                output[day]!.append(point)
            } else {
                output[day] = [point]
            }
        }
        
        return output
    }
    
    /// Returns an array of all the stops in this `Route`.
    ///
    /// A stop is a boundary between two `RoutePoint`s with different `day`
    /// properties. This function returns the last `RoutePoint` for all `RoutePoint`s
    /// with a particular `day`.
    var stops: [RoutePoint] {
        var currentDay = 1
        var stops: [RoutePoint] = []
        
        for i in 0..<self.points.count {
            guard let day = points[i].day else { continue }
            
            if day != currentDay {
                stops.append(points[i - 1])
                
                currentDay += 1
            }
        }
        
        return stops
    }
}
