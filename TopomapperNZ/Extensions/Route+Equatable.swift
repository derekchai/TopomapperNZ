//
//  Route+Equatable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 08/07/2024.
//

import Foundation

extension Route: Equatable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.name == rhs.name && lhs.creationDate == rhs.creationDate
    }
}
