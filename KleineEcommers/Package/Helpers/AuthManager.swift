//
//  AuthManager.swift
//  ArchitectureTestingApp
//
//  Created by Yousef on 10/26/21.
//

import SwiftUI

class AuthManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    static var shared = AuthManager()
    
    private init() { }
    
    
    func login() {
        isLoggedIn = true
    }
    
    func register() {
        isLoggedIn = true
    }
}
