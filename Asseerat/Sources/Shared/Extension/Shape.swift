//
//  Shape.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/09/25.
//

import SwiftUI

struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // Use points in a normalized coordinate system then scale to rect
        let w = rect.width
        let h = rect.height

        // These control points can be adjusted to change the look
        let start = CGPoint(x: 0.18 * w, y: 0.55 * h)   // left-down
        let mid   = CGPoint(x: 0.42 * w, y: 0.75 * h)   // mid-bottom
        let end   = CGPoint(x: 0.82 * w, y: 0.28 * h)   // right-up

        path.move(to: start)
        path.addLine(to: mid)
        path.addLine(to: end)
        return path
    }
}
