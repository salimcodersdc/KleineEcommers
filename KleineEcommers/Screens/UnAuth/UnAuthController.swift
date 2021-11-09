//
//  UnAuthController.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct UnAuthController: View {
    
    @State private var page: Page = .welcome
    
    var body: some View {
        if page == .welcome {
            WelcomeScreen(page: $page)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeIn, value: page)
        } else if page == .choice {
            UnAuthChoiceScreen(page: $page)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeIn, value: page)
        } else if page == .login {
            LoginScreen(page: $page)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeIn, value: page)
        } else if page == .register {
            RegisterScreen(page: $page)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .animation(.easeIn, value: page)
        }
    }
}

extension UnAuthController {
    enum Page {
        case welcome, choice, register, login
    }
}

struct UnAuthController_Previews: PreviewProvider {
    static var previews: some View {
        UnAuthController()
    }
}
