//
//  LoginToggle.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

struct LoginToggle: UIViewRepresentable {

    @Binding private var isOn: Bool
    
    init (isOn: Binding<Bool>) {
        _isOn = isOn
    }

    func updateUIView(_ uiView: PWSwitch, context: Context) {
        uiView.setOn(isOn, animated: true)
    }

    func makeCoordinator() -> Coordinator { Coordinator(isOn: $isOn) }
    
    func makeUIView(context: Context) -> PWSwitch {
        let customSwitch = PWSwitch()
        customSwitch.frame = CGRect(x: 0, y: 0, width: 32, height: 16)
        // TODO:
        customSwitch.shadowStrength = 0
        customSwitch.thumbShadowColor = .clear
        customSwitch.thumbOnFillColor = .white
        customSwitch.thumbOnBorderColor = .white
        if let color = UIColor(named: "lightBlue") {
            customSwitch.trackOnFillColor = color
            customSwitch.trackOnBorderColor = color

            customSwitch.thumbOffFillColor = color.withAlphaComponent(0.5)
            customSwitch.thumbOffBorderColor = color.withAlphaComponent(0.5)
            customSwitch.thumbOffPushBorderColor = color.withAlphaComponent(0.5)
            customSwitch.trackOffFillColor = color.withAlphaComponent(0.25)
            customSwitch.trackOffBorderColor = color.withAlphaComponent(0.25)
            customSwitch.trackOffPushBorderColor = color.withAlphaComponent(0.25)
        }

        customSwitch.shouldFillOnPush = false
        customSwitch.thumbDiameter = 16
        customSwitch.thumbCornerRadius = 8
        customSwitch.trackInset = 0
        customSwitch.cornerRadius = 8
        
        customSwitch.setOn(isOn, animated: false)
        customSwitch.addTarget(
            context.coordinator,
            action: #selector(Coordinator.callHandler(sender:)),
            for: .valueChanged
        )

        return customSwitch
    }
}

extension LoginToggle {
    class Coordinator: NSObject {
        
        @Binding private var isOn: Bool

        init (isOn: Binding<Bool>) {
            _isOn = isOn
        }
        
        @objc func callHandler(sender: PWSwitch) {
            isOn = sender.on
        }
    }
}
