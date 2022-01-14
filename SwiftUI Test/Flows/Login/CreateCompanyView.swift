//
//  CreateCompanyView.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 23.11.2021.
//

import SwiftUI

struct CreateCompanyView: View {
    
    @Binding var isCreateCompanyViewShown: Bool
    @State private var isStartedAnimationOnAppear = false
    @State private var isAppearAnimated = false
    @State private var isTypeToNameViewFlipped = false
    @State private var isTypeSelected = false
    @State private var stage = Stage.type
    @State private var isEditing = false
    @State private var isNameFocused = false
    
    @EnvironmentObject var companyModel: CompanyModel
    
    @StateObject var keyboardHeightWorker = KeyboardHeightWorker()
    
    private enum Stage {
        case type
        case name
        case createProfile
    }
    
    private var spacer16: some View {
        Spacer()
            .frame(height: 16)
            .padding(0)
    }
    
    var body: some View {
        let blurViewOpacity = isStartedAnimationOnAppear ? 1.0 : 0.0
        
        let baseValue = 180.0
        let flipDegrees = isTypeToNameViewFlipped ? baseValue : 0
        let inputViewOpacity = isTypeToNameViewFlipped ? 1.0 : 0.0
        
        let height = CGFloat(44)
        
        ZStack(alignment: .bottom) {
            LoginBlurView()
                .opacity(blurViewOpacity)
                .onAnimationCompleted(for: blurViewOpacity) {
                    if isAppearAnimated {
                        // disappearing view trigger and animation
                        isCreateCompanyViewShown = false
                    }
                    isAppearAnimated = true
                }
                .onTapGesture(count: 1) {
                    withAnimation {
                        resetStatesOnCloseCreateCompanyView()
                    }
                }
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 2)
                
                HStack(alignment: .center) {
                    Button(action: {
                        if stage != .type {
                            withAnimation {
                                switch stage {
                                case .name:
                                    resetTypeActionsState()
                                    companyModel.name = ""
                                    stage = .type
                                case .createProfile:
                                    stage = .name
                                default: break
                                }
                            }
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    .frame(width: 56)
                    .padding(.trailing, 0)
                    .opacity((stage == .type) ? 0 : 1)
                    
                    Text("Create Company")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    Button(action: {
                        withAnimation {
                            resetStatesOnCloseCreateCompanyView()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .frame(width: 56)
                    .padding(.trailing, 0)
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .padding(0)
                
                Spacer()
                    .frame(height: 26)
                    .padding(0)
                
                if stage == .type {
                    Text("Number of workers:")
                        .frame(height: 19)
                        .padding(0)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    spacer16
                }
                
                HStack(alignment: .center) {
                    GeometryReader { metrics in
                        ZStack {
                            HStack {
                                SelectTypeAvatarButton(
                                    isTypeSelected: $isTypeSelected,
                                    buttonType: .single
                                )
                                
                                if !isTypeSelected {
                                    Spacer()
                                        .frame(width: metrics.size.width / 2)
                                }
                            }
                            .zIndex((isTypeSelected && companyModel.type == .single) ? 1 : 0)
                            
                            HStack {
                                if !isTypeSelected {
                                    Spacer()
                                        .frame(width: metrics.size.width / 2)
                                }
                                
                                SelectTypeAvatarButton(
                                    isTypeSelected: $isTypeSelected,
                                    buttonType: .multiple
                                )
                            }
                            .zIndex((isTypeSelected && companyModel.type == .multiple) ? 1 : 0)
                        }
                    }
                }
                .frame(height: 113)
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 14)
                
                VStack(spacing: 0) {
                    spacer16
                    
                    ZStack() {
                        VStack(spacing: 0) {
                            LoginTypePicker(isTypeSelected: $isTypeSelected)
                                .pickerStyle(SegmentedPickerStyle())
                                .frame(height: 28)
                                .padding(0)
                                .padding([.leading, .trailing], 16)
                                .cornerRadius(14, corners: .allCorners)
                                .verticalFlipRotate(flipDegrees)
                                .opacity(isTypeToNameViewFlipped ? 0.0 : 1.0)
                            
                            Spacer()
                                .frame(maxHeight: .infinity)
                        }
                        
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(.white)
                                .frame(width: 40, height: height)
                                .padding(0)
                                .opacity(companyModel.name.isEmpty ? 0.5 : 1)
                            
                            // TODO: switch to .focused() usage when least supported iOS will be 15.0
                            UniversalTextField(
                                text: $companyModel.name,
                                inEditing: $isEditing,
                                isFirstResponder: $isNameFocused,
                                onSubmit: {
                                    isNameFocused = false
                                })

                            if !companyModel.name.isEmpty {
                                Button {
                                    companyModel.name = ""
                                } label: {
                                    Image(systemName: "multiply.circle")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: height)
                                .padding(0)
                            }
                        }
                        .frame(height: height)
                        .frame(maxWidth: .infinity)
                        .background(Color("darkPrimaryBackground"))
                        .cornerRadius(CGFloat(height / 2), corners: .allCorners)
                        .verticalFlipRotate(-baseValue + flipDegrees)
                        .opacity(inputViewOpacity)
                    }
                    .animation(.default)
                    .frame(height: 44)
                    .padding([.leading, .trailing], 16)
                    
                    spacer16
                }
                .frame(height: 76)
                .padding(0)
                
                VStack(spacing: 0) {
                    if stage == .type {
                        Button(action: {
                            if companyModel.type != nil {
                                withAnimation {
                                    isTypeSelected = true
                                    isTypeToNameViewFlipped = true
                                    stage = .name
                                }
                                isNameFocused = true
                            }
                        }) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .font(.system(size: 58.0, weight: .thin))
                                .foregroundColor(.white)
                                .opacity((companyModel.type == nil) ? 0.5 : 1.0)
                        }
                        .frame(width: 58, height: 58)
                        .padding(0)
                        .buttonStyle(NoHighlightButtonStyle(color: .clear))
                        
                        Spacer()
                            .frame(height: 32)
                            .padding(0)
                    }
                }
                .padding(0)
                .frame(height: bottomStackHeight())
            }
            .frame(maxWidth: .infinity)
            .frame(height: backgroundViewHeight())
            .background(Color("darkPrimaryBackground"))
            .cornerRadius(16, corners: [.topLeft, .topRight])
        }
        .onAppear {
            withAnimation {
                isStartedAnimationOnAppear = true
            }
        }
    }
}

extension CreateCompanyView {
    private func backgroundViewHeight() -> CGFloat {
        let baseTypeHeight = CGFloat(398)
        let baseNameHeight = CGFloat(273)
        switch stage {
        case .type: return isStartedAnimationOnAppear ? baseTypeHeight : 0
        case .name:
            // TODO: WIP
            let keyboardHeight = keyboardHeightWorker.keyboardHeight
            return baseNameHeight + keyboardHeight
        case .createProfile: return baseNameHeight  // TODO:
        }
    }
    
    private func bottomStackHeight() -> CGFloat {
        switch stage {
        case .type: return CGFloat(90)
        case .name:
            // TODO:
            let keyboardHeight = keyboardHeightWorker.keyboardHeight
            print("kh - \(keyboardHeight)")
            return keyboardHeight
        case .createProfile: return 100.0  // TODO:
        }
    }
    
    private func resetTypeActionsState() {
        isTypeSelected = false
        isTypeToNameViewFlipped = false
        isNameFocused = false
    }
    
    private func resetStatesOnCloseCreateCompanyView() {
        isStartedAnimationOnAppear = false
        
        resetTypeActionsState()
        companyModel.resetData()
    }
}

struct CreateCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCompanyView(isCreateCompanyViewShown: .constant(true))
    }
}
