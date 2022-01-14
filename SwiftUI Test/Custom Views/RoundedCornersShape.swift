//
//  RoundedCornersShape.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 23.11.2021.
//

import SwiftUI

struct RoundedCornersShape: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
