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
}
