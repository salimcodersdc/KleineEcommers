//
//  KelineTestScreen.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 11/8/21.
//

import SwiftUI

// #000DAE

struct WelcomeScreen: View {
    
    @Binding var page: UnAuthController.Page
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                
                Color.theme.alternativeBackground
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        KelineMobile()
                            .padding(.top, 32)
                        
                        fogEffect
                        
                        HStack {
                            KelinePartLogoShape()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .offset(y: -15)
                            
                            Text("Kleine.")
                                .font(Font.fontBook.bold(34))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 300, height: 600)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    
                    HStack {
                        Capsule() // 849DFE
                            .fill(Color.theme.alternativeBackground)
                            .frame(width: 75, height: 5)
                        Capsule()
                            .fill(Color.theme.alternativeBackground.opacity(0.5))
                            .frame(width: 50, height: 5)
                        Capsule()
                            .fill(Color.theme.alternativeBackground.opacity(0.5))
                            .frame(width: 50, height: 5)
                    }
                    .padding(.bottom, 16)
                    .padding(.top, 32)
                    
                    Text("The Right Address For\nShopping Anyday")
                        .font(Font.fontBook.bold(28))
                        .foregroundColor(Color.theme.primaryText)
                        .multilineTextAlignment(.center)
                    
                    Text("It is now very easy to reach the best quality\namong all the products on the internet!")
                        .font(Font.fontBook.regular(12))
                        .foregroundColor(Color.theme.alternativeText)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    
                    Button(action: {
                        page = .choice
                    }, label: {
                        Text("Next")
                            .font(Font.fontBook.semiBold(12))
                            .foregroundColor(Color.theme.primary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 32)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.theme.primary)
                            )
                    })
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: proxy.size.height * 0.5)
                .background(
                    Color.white
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
        }
        
    }
}

extension WelcomeScreen {
    private var fogEffect: some View {
        FogShape(diversion: 0)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.fromHexString("#909BFE"),
                        Color.blue,
                        Color.clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 150, height: 200)
            .blur(radius: 20)
            .opacity(0.4)
            .offset(y: -50)
    }
}

struct KelineTestScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(page: .constant(.welcome))
    }
}
