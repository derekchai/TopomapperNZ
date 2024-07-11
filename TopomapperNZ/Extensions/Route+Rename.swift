//
//  Route+Rename.swift
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
}
