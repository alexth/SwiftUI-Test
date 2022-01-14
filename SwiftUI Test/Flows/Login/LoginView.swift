//
//  ContentView.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 22.11.2021.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    
    @State private var isSwitchOn = true
    @State private var isCreateCompanyViewShown = false
    
    @StateObject var companyModel = CompanyModel()
    
    private let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    
    let playerZStack: some View = ZStack(alignment: .topLeading) {
        PlayerView()
        
        Button(action: {
            // TODO:
        }, label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
        })
            .frame(width: 24, height: 24, alignment: .topLeading)
            .padding(24)
    }
    let onlineHStack: some View = HStack(spacing: 6) {
        Image(systemName: "circle.fill")
            .frame(width: 5, height: 5)
            .foregroundColor(.green)
        
        Text("10000 users online")
            .foregroundColor(.white)
            .font(.headline)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            let buttonsStackHeight = CGFloat(415)
            let buttonsCornerRadius = CGFloat(16)
            
            VStack(spacing: 0) {
                playerZStack
                
                if deviceIdiom != .pad {
                    Spacer()
                        .frame(height: buttonsStackHeight - buttonsCornerRadius)
                }
            }
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(maxHeight: 48)
                    
                    Text("Welcome to the App")
                        .frame(height: 28)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                    Spacer()
                        .frame(height: 26)
                    
                    
                    
//                    onlineHStack
//                        .frame(height: 19)
                    HStack(spacing: 6) {
                        Image(systemName: "circle.fill")
                            .frame(width: 5, height: 5)
                            .foregroundColor(.green)
                            
                        Text("10000 users online")
                            .foregroundColor(.white)
                            .font(.headline)
                    }

                    
                    
                    
                    Spacer()
                        .frame(height: 32)
                    
                    VStack(spacing: 16) {
                        LoginButton(
                            isSwitchOn: $isSwitchOn,
                            backgroundColor: Color("facebookLoginButton"),
                            title: "Login with Facebook",
                            onPress: {
                                print("FB")
                            },
                            icon: "Facebook"
                        )
                        
                        LoginButton(
                            isSwitchOn: $isSwitchOn,
                            backgroundColor: .black,
                            title: "Continue with Apple",
                            onPress: {
                                print("Apple")
                            },
                            icon: "Apple"
                        )
                        
                        // TODO: connect sign in button to our custom button
                        //                                            SignInWithAppleButton(
                        //                                                .signIn,
                        //                                                onRequest: viewModel.configure(_:),
                        //                                                onCompletion: viewModel.handle(_:)
                        //                                            )
                        //                                                .frame(height: 44)
                        //                                                .signInWithAppleButtonStyle(.black)
                        //                                                .cornerRadius(22, corners: .allCorners)
                        
                        LoginButton(
                            isSwitchOn: $isSwitchOn,
                            backgroundColor: .clear,
                            title: "Create Company",
                            titleTextColor: Color("lightBlue"),
                            onPress: { isCreateCompanyViewShown =  true }
                        )
                    }
                    .frame(height: 180)
                    .padding([.leading, .trailing], 16)
                    
                    GeometryReader { metrics in
                        HStack(alignment: .bottom, spacing: 16) {
                            HStack {
                                Spacer()
                                
                                LoginToggle(isOn: $isSwitchOn)
                                    .frame(width: 32, height: 16, alignment: .top)
                                    .padding(0)
                            }
                            .frame(width: metrics.size.width * 0.24, height: 28)
                            .padding(0)
                            
                            let text = Text("I agree with the app's ")
                            + Text("User agreement")
                                .foregroundColor(Color("lightBlue"))
                            text
                                .padding(0)
                                .foregroundColor(.white)
                                .font(.caption)
                                .lineLimit(3)
                                .onTapGesture(count: 1) {
                                    // TODO: move to user agreement
                                }
                            
                            Spacer().frame(width: 16)
                        }
                        .padding(0)
                        .frame(height: 92)
                    }
                    .padding(0)
                }
                .frame(height: buttonsStackHeight)
                .background(Color("darkPrimaryBackground"))
                .cornerRadius(buttonsCornerRadius, corners: [.topLeft, .topRight])
                
                if isCreateCompanyViewShown {
                    CreateCompanyView(isCreateCompanyViewShown: $isCreateCompanyViewShown)
                        .environmentObject(companyModel)
                }
            }
            .padding([.leading, .trailing], (deviceIdiom == .pad) ? 100 : 0)
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 8")
    }
}
