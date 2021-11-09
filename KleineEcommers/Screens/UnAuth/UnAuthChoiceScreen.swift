//
//  UnAuthChoiceScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct UnAuthChoiceScreen: View {
    
    @Binding var page: UnAuthController.Page
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.theme.mainBackground
            
            PartialMobileBackground(showLogo: true)
            
            content
        }
    }
}

extension UnAuthChoiceScreen {
    private var content: some View {
        VStack {
            Spacer()
                .frame(height: 430)
            
            Text("The Right Address\nFor Shopping\nAnyday")
                .font(Font.fontBook.semiBold(28))
                .foregroundColor(Color.theme.primaryText)
                .multilineTextAlignment(.center)
            
            Text("It is now very easy to reach the best quality among all the products on the internet!")
                .kerning(1.0)
                .font(Font.fontBook.regular(12))
                .foregroundColor(Color.theme.alternativeText)
                .lineSpacing(10.0)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .padding(.top)
            
            HStack(spacing: 0) {
                Button(action: {
                    page = .register
                }, label: {
                    Text("Register")
                        .font(Font.fontBook.semiBold(13))
                        .foregroundColor(Color.white)
                        .padding()
                        .padding(.horizontal)
                        .background(
                            Color.theme.primary
                                .cornerRadius(8)
                        )
                })
                
                Button(action: {
                    page = .login
                }, label: {
                    Text("Login")
                        .font(Font.fontBook.semiBold(13))
                        .foregroundColor(Color.white)
                        .padding()
                        .padding(.horizontal)
                        .background(
                            Color.theme.alternativeText
                                .cornerRadius(8)
                        )
                })
            }
            .padding(.top, 50)
        }
        .padding()
    }
}

struct UnAuthChoiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthChoiceScreen(page: .constant(.choice))
    }
}
