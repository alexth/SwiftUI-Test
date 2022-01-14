//
//  SelectTypeAvatarButton.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

struct SelectTypeAvatarButton: View {
    
    @Binding private var isTypeSelected: Bool
    @EnvironmentObject var companyModel: CompanyModel

    private let buttonType: CompanyType
    
    init (isTypeSelected: Binding<Bool>, buttonType: CompanyType) {
        _isTypeSelected = isTypeSelected
        self.buttonType = buttonType
    }
    
    var body: some View {
        Button(action: {
            if !isTypeSelected {
                withAnimation {
                    companyModel.type = buttonType
                }
            }
        }) {
            ZStack {
                Spacer().frame(maxWidth: .infinity)
                Image((buttonType == .multiple) ? "iconMale" : "iconFemale")
                    .shadow(
                        color: Color((buttonType == .multiple) ? "maleBlue" : "femalePink"),
                        radius: !isTypeSelected ? ((companyModel.type == buttonType) ? 22 : 0) : 0,
                        x: 0,
                        y: 0
                    )
            }
        }
        .opacity(typeAvatarOpacity(type: buttonType))
        .frame(alignment: .center)
        .padding(0)
        .buttonStyle(NoHighlightButtonStyle(color: .clear))
    }
    
    private func typeAvatarOpacity(type: CompanyType) -> Double {
        if companyModel.type == nil {
            return 1.0
        } else {
            if type == companyModel.type {
                return 1.0
            } else {
                return 0.5
            }
        }
    }
}

struct SelectTypeAvatarButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectTypeAvatarButton(isTypeSelected: .constant(true), buttonType: .single)
    }
}
