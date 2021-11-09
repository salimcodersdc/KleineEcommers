//
//  MobileBackgroundLayer.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct MobileBackgroundLayer: View {
    
    var showLogo: Bool
    
    var darkColor: Color = Color.fromHexString("#B0B6FF")
    var lightColor: Color = Color.fromHexString("#F5F8FA")
    
    var body: some View {
        VStack {
            ZStack {
                KelineMobile()
                    .darkColor(darkColor)
                    .lightColor(lightColor)
                    .padding(.top, 32)
                
                fogEffect
                
                if showLogo {
                    LogoView()
                }
            }
            .frame(width: 300, height: 600)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

extension MobileBackgroundLayer {
    private var fogEffect: some View {
        FogShape(diversion: 0)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.fromHexString("#909BFE"),
                        Color.blue.opacity(0.6),
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

struct MobileBackgroundLayer_Previews: PreviewProvider {
    static var previews: some View {
        MobileBackgroundLayer(showLogo: true)
    }
}
