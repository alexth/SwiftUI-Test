//
//  NoHighlightButtonStyle.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

struct NoHighlightButtonStyle: ButtonStyle {
    
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? color.lighter(by: 0.25) : color)
    }
}
