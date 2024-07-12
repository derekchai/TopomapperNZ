//
//  Double+Rounding.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 12/07/2024.
//

import Foundation

extension Double {
    /// Rounds the `Double` to the given number of decimal places.
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: The rounded `Double`.
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
