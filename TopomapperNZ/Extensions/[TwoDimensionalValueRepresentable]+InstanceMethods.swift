//
//  [TwoDimensionalValueRepresentable]+InstanceMethods.swift
//  TopomapperNZ
//
//  Created by Derek Chai on 16/07/2024.
//

import Foundation

extension Array where Element: TwoDimensionalValueRepresentable {
    /// Decimates (downsamples) an array of values representing a 2D curve
    /// composed of line segments to a similar curve with fewer points.
    ///
    /// This method uses the Ramer-Douglas-Peucker algorithm to decimate a curve
    /// from many line segments to one from fewer line segments.
    /// - Parameter epsilon: The decimation factor. Higher values produce lower-
    /// quality curves.
    /// - Returns: The decimated array.
    /// - Complexity: O(n²) in the worst case.
    func decimated(ε epsilon: Double) -> [Element] {
        guard self.count >= 2 else {
            return self
        }
        
        var maxDistance: Double = 0
        var index = 0
        let end = self.count - 1
        
        for i in 1..<end {
            let distance = perpendicularDistance(from: self[i], toLine: (self[0], self[end]))
            
            if distance > maxDistance {
                index = i
                maxDistance = distance
            }
        }
        
        if maxDistance > epsilon {
            let recursiveResults1 = Array(self[0...index]).decimated(ε: epsilon)
            let recursiveResults2 = Array(self[index...end]).decimated(ε: epsilon)
            
            var resultList = recursiveResults1
            resultList.removeLast()
            resultList.append(contentsOf: recursiveResults2)
            return resultList
        } else {
            return [self[0], self[end]]
        }
    }
}

/// Returns the perpindicular distance from a point to a line.
/// - Parameters:
///   - point: The point whose distance from the line is being measured.
///   - toLine: A tuple defining the start and end points of a line segment.
/// - Returns: The perpendicular distance from the point to the line.
fileprivate func perpendicularDistance<T: TwoDimensionalValueRepresentable>(
    from point: T,
    toLine line: (T, T)
) -> Double {
    let numerator: Double = abs((line.1.y - line.0.y) * point.x - (line.1.x - line.0.x) * point.y + line.1.x * line.0.y - line.1.y * line.0.x)
    let denominator = sqrt(pow(line.1.y - line.0.y, 2) + pow(line.1.x - line.0.x, 2))
    
    return numerator / denominator
}
