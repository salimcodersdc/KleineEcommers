//
//  LoginViewModel.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    private var service: LoginViewModelServiceProtocol
    
    init(service: LoginViewModelServiceProtocol) {
        self.service = service
    }
}
