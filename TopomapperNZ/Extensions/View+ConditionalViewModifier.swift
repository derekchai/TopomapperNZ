//
//  View+ConditionalViewModifier.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 10/07/2024.
//

import Foundation
import SwiftUI

extension View {
    /// Applies the given transformation if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to check.
    ///   - transform: The transformation to apply.
    /// - Returns: The view, with or without transformation, depending on the
    /// given condition.
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
