//
//  LogoView.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct LogoView: View {
    
    private var color: Color
    private var size: CGFloat
    private var font: CGFloat
    
    init() {
        color = .white
        size = 30
        font = 34
    }
    
    var body: some View {
        HStack {
            KelinePartLogoShape()
                .fill(color)
                .frame(width: size, height: size)
                .offset(y: -size * 0.5)
            
            Text("Kleine.")
                .font(Font.fontBook.regular(font))
                .foregroundColor(color)
        }
    }
    
    func labelColor(_ color: Color) -> LogoView {
        var view = self
        view.color = color
        return view
    }
    
    func imageSize(_ size: CGFloat) -> LogoView {
        var view = self
        view.size = size
        return view
    }
    
    func fontSize(_ size: CGFloat) -> LogoView {
        var view = self
        view.font = size
        return view
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LogoView()
                .padding()
        }
        .background(Color.gray)
    }
}
