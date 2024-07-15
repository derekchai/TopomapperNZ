//
//  GradeFormatStyle.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 15/07/2024.
//

import Foundation

struct GradeFormatStyle: FormatStyle {
    typealias FormatInput = Double
    typealias FormatOutput = String

    func format(_ value: Double) -> String {
        String(format: "%.1f%", value * 100)
    }
}

extension FormatStyle where Self == GradeFormatStyle {
    /// A style for formatting grade as a percentage.
    static var grade: Self { Self() }
}
