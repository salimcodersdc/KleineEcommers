//
//  PartialMobileBackground.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct PartialMobileBackground: View {
    
    var showLogo: Bool
    
    var darkColor: Color = Color.fromHexString("#B0B6FF")
    var lightColor: Color = Color.fromHexString("#F5F8FA")
    
    var body: some View {
        ZStack(alignment: .top) {
            partialPradientLayer
            
            MobileBackgroundLayer(showLogo: showLogo, darkColor: darkColor, lightColor: lightColor)
                .mask(
                    Circle()
                        .frame(width: 540, height: 540)
                        .offset(y: -300)
                )
        }
    }
}

extension PartialMobileBackground {
    var partialPradientLayer: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.45)
        .background(
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.fromHexString("000DAE").opacity(0.6),
                    Color.fromHexString("849DFE").opacity(0.6),
                    Color.fromHexString("DDD9FE").opacity(0.6),
                    Color.clear
                ]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
                .blur(radius: 15)
                .edgesIgnoringSafeArea(.top)
        )
    }
}

struct PartialMobileBackground_Previews: PreviewProvider {
    static var previews: some View {
        PartialMobileBackground(showLogo: true)
    }
}
