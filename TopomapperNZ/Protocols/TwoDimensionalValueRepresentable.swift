//
//  TwoDimensionalValueRepresentable.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 16/07/2024.
//

import Foundation

/// A data model which represents some two-dimensional value, such as a coordinate.
protocol TwoDimensionalValueRepresentable {
    /// One of the value's two dimensions.
    var x: Double { get }
    
    /// One of the value's two dimensions.
    var y: Double { get }
}
