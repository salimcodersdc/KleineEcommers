//
//  ContentView.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var authManager = AuthManager.shared
    
    var body: some View {
//        if authManager.isLoggedIn {
//            AuthController()
//                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
//                .animation(.easeIn, value: authManager.isLoggedIn)
//        } else {
//            UnAuthController()
//                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
//                .animation(.easeIn)
//        }
        
        AuthController()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
