//
//  UniversalTextField.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 23.11.2021.
//

import SwiftUI

struct UniversalTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        @Binding var inEditing: Bool
        @Binding var isFirstResponder: Bool
        var onSubmit: () -> Void

        init(
            text: Binding<String>,
            inEditing: Binding<Bool>,
            isFirstResponder: Binding<Bool>,
            onSubmit: @escaping () -> Void
        ) {
            _text = text
            _inEditing = inEditing
            _isFirstResponder = isFirstResponder
            self.onSubmit = onSubmit
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isFirstResponder = false
            self.onSubmit()
            return true
        }
    }

    @Binding var text: String
    @Binding var inEditing: Bool
    @Binding var isFirstResponder: Bool
    var onSubmit: () -> Void

    func makeUIView(context: UIViewRepresentableContext<UniversalTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.autocapitalizationType = .words
        textField.textColor = UIColor(.white)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(Color("lightBlue").opacity(0.5))]
        )
        return textField
    }

    func makeCoordinator() -> UniversalTextField.Coordinator {
        return Coordinator(
            text: $text,
            inEditing: $inEditing,
            isFirstResponder: $isFirstResponder,
            onSubmit: onSubmit
        )
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<UniversalTextField>) {
        uiView.text = text
        if isFirstResponder {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
}
