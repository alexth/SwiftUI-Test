//
//  LoginTypePicker.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

struct LoginTypePicker: View {
    
    @Binding var isTypeSelected: Bool
    @EnvironmentObject var companyModel: CompanyModel
    
    private let backgroundColor = Color("darkPrimaryBackground")
    
    private var infiniteHorizontalSpacer: some View {
        Spacer()
            .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        let height = CGFloat(28)
        let padding = CGFloat(2)
        let doublePadding = padding * 2
        
        GeometryReader { metrics in
            let backgroundOvalWidth = (metrics.size.width / 2) - doublePadding
            let backgroundOvalHeight = height - doublePadding
            
            HStack() {
                if isTypeSelected {
                    Spacer()
                }
                
                ZStack {
                    HStack {
                        if companyModel.type == .single && !isTypeSelected { infiniteHorizontalSpacer }
                        
                        backroundColor(type: companyModel.type)
                            .frame(
                                width: isTypeSelected ? backgroundOvalWidth - doublePadding : backgroundOvalWidth,
                                height: backgroundOvalHeight
                            )
                            .cornerRadius(backgroundOvalHeight / 2, corners: .allCorners)
                            .padding(padding)
                        
                        if companyModel.type == .multiple && !isTypeSelected { infiniteHorizontalSpacer }
                    }
                    
                    HStack(alignment: .center) {
                        if isTypeSelected == false {
                            typeView(buttonType: .multiple, padding: padding)
                            
                            typeView(buttonType: .single, padding: padding)
                        } else {
                            if companyModel.type == .multiple {
                                typeView(buttonType: .multiple, padding: padding)
                                    .frame(alignment: .center)
                            }
                            
                            if companyModel.type == .single {
                                typeView(buttonType: .single, padding: padding)
                                    .frame(alignment: .center)
                            }
                        }
                    }
                }
                .frame(height: 28, alignment: .center)
                .frame(maxWidth: isTypeSelected ? backgroundOvalWidth : .infinity)
                .background(backgroundColor)
                .cornerRadius(22, corners: .allCorners)
                
                if isTypeSelected {
                    Spacer()
                }
            }
        }
    }
}

extension LoginTypePicker {
    private func backroundColor(type: CompanyType?) -> Color {
        switch type {
        case .multiple:
            return Color("maleBlue")
        case .single:
            return Color("femalePink")
        default:
            return .clear
        }
    }
    
    private func typeView(buttonType: CompanyType, padding: CGFloat) -> some View {
        let button = Button(action: {
            withAnimation {
                companyModel.type = buttonType
            }
        }) {
            ZStack {
                Color.clear
                HStack {
                    Text(buttonType == .multiple ? "Single" : "Multiple")
                        .frame(height: 16)
                        .padding(0)
                        .font(.callout)
                        .foregroundColor((buttonType == companyModel.type) ? backgroundColor : .white)
                    
                    Image((companyModel.type == nil) ? nonSelectedIconSign(buttonType: buttonType) : selectedIconSign(buttonType: buttonType))
                        .frame(width: 12, height: 12)
                        .padding(0)
                }
            }
        }
            .buttonStyle(NoHighlightButtonStyle(color: .clear))
            .padding(padding)
        
        return button
    }
    
    private func nonSelectedIconSign(buttonType: CompanyType) -> String {
        switch buttonType {
        case .multiple: return "maleSignDisabled"
        case .single: return "femaleSignDisabled"
        default: return ""
        }
    }
    
    private func selectedIconSign(buttonType: CompanyType) -> String {
        if buttonType == companyModel.type {
            switch companyModel.type {
            case .some(.multiple): return "maleSignEnabled"
            case .some(.single): return "femaleSignEnabled"
            default: return ""
            }
        } else {
            return nonSelectedIconSign(buttonType: buttonType)
        }
    }
}

struct LoginTypePicker_Previews: PreviewProvider {
    static var previews: some View {
        LoginTypePicker(isTypeSelected: .constant(false))
    }
}
