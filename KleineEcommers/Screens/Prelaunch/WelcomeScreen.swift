//
//  KelineTestScreen.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 11/8/21.
//

import SwiftUI

// #000DAE

struct WelcomeScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                
                Color.fromHexString("#849DFE")
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
                                .font(Font.book.bold(24))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 300, height: 600)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack {
                    
                    HStack {
                        Capsule()
                            .fill(Color.fromHexString("#849DFE"))
                            .frame(width: 75, height: 5)
                        Capsule()
                            .fill(Color.fromHexString("#849DFE").opacity(0.5))
                            .frame(width: 50, height: 5)
                        Capsule()
                            .fill(Color.fromHexString("#849DFE").opacity(0.5))
                            .frame(width: 50, height: 5)
                    }
                    .padding(.bottom, 16)
                    .padding(.top, 32)
                    
                    Text("The Right Address For\nShopping Anyday")
                        .font(Font.book.bold(28))
                        .multilineTextAlignment(.center)
                    
                    Text("It is now very easy to reach the best quality\namong all the products on the internet!")
                        .font(Font.book.regular(12))
                        .foregroundColor(Color.fromHexString("#979797"))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    
                    Button(action: {}, label: {
                        Text("Next")
                            .font(Font.book.semiBold(12))
                            .foregroundColor(Color.fromHexString("#000DAE"))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 32)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.fromHexString("#000DAE"))
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
        WelcomeScreen()
    }
}
