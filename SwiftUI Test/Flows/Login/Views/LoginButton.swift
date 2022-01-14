//
//  LoginButton.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

struct LoginButton: View {
    
    @Binding private var isSwitchOn: Bool
    
    private let backgroundColor: Color
    private let title: String
    private let titleTextColor: Color
    private let height: CGFloat
    private let onPress: () -> Void
    private let icon: String?
            
    init (
        isSwitchOn: Binding<Bool>,
        backgroundColor: Color,
        title: String,
        titleTextColor: Color = .white,
        height: CGFloat = 44,
        onPress: @escaping () -> Void,
        icon: String? = nil
    ) {
        _isSwitchOn = isSwitchOn
        self.title = title
        self.backgroundColor = backgroundColor
        self.titleTextColor = titleTextColor
        self.height = height
        self.onPress = onPress
        self.icon = icon
    }
    
    var body: some View {
        let opacity = isSwitchOn ? 1 : 0.5
        ZStack {
            Button(action: onPress) {
                HStack(spacing: 0) {
                    if let iconName = icon {
                        Image(iconName)
                            .padding(.trailing, 20)
                            .opacity(opacity)
                    }
                    
                    Text(title)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(titleTextColor)
                        .font(.title2)
                        .opacity(opacity)
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
            }
            .cornerRadius(height / 2, corners: .allCorners)
            .buttonStyle(NoHighlightButtonStyle(color: backgroundColor))
            .disabled(!isSwitchOn)
        }
    }
}

struct LoginButtonView_Previews: PreviewProvider {

    static var previews: some View {
        LoginButton(
            isSwitchOn: .constant(true),
            backgroundColor: Color("vkLoginButton"),
            title: "Login with Social Network",
            onPress: {
                print("button tapped")
            },
            icon: "VK"
        )
    }
}
