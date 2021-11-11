//
//  AuthController.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI

struct AuthController: View {
    
    @State private var selection: TabBarItem = .home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selection) {
                    HomeScreen()
                        .tag(TabBarItem.home)
                    
                    SearchScreen()
                        .tag(TabBarItem.search)
                    
                    CartScreen()
                        .tag(TabBarItem.cart)
                    
                    ProfileScreen()
                        .tag(TabBarItem.profile)
                }
                .overlay(
                    TabBarView(selection: $selection)
                    , alignment: .bottom
                )
                .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension AuthController {
    enum TabBarItem: Identifiable, CaseIterable {
        case home
        case search
        case cart
        case profile
        
        var id: String {
            switch self {
            case .home:
                return "Home"
            case .search:
                return "Search"
            case .cart:
                return "Cart"
            case .profile:
                return "Profile"
            }
        }
        
        var icon: String {
            switch self {
            case .home:
                return "Home"
            case .search:
                return "Search"
            case .cart:
                return "Bag"
            case .profile:
                return "Profile"
            }
        }
    }
}

struct AuthController_Previews: PreviewProvider {
    static var previews: some View {
        AuthController()
    }
}
