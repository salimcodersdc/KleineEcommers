//
//  LoginViewModel.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var userName: String = "user@gmail.com"
    @Published var password: String = "P@ssw0rd"
    @Published var isValid: Bool = false
    
    @Published var isUserNameValid: Bool = false
    @Published var isPasswordValid: Bool = false
    
    var emailValidationMessage: String? {
        if isUserNameValid {
            return nil
        } else {
            return "Please enter valid email"
        }
    }
    
    var passwordValidationMessage: String? {
        if isPasswordValid {
            return nil
        } else {
            return "Password should be atleast 8 letters"
        }
    }
    
    private var service: LoginViewModelServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: LoginViewModelServiceProtocol) {
        self.service = service
        addSubcripers()
    }
    
    private func addSubcripers() {
        $userName
            .map(evaluateEmail)
            .sink { [unowned self] valid in
                self.isUserNameValid = valid
            }
            .store(in: &cancellables)
        
        $password
            .map(evaluatePassword)
            .sink { [unowned self] valid in
                isPasswordValid = valid
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($isUserNameValid, $isPasswordValid)
            .map(evaluateForm)
            .sink { [unowned self] valid in
                isValid = valid
            }
            .store(in: &cancellables)
            
    }
    
    //MARK: - Validation Stuff
    private func evaluateEmail(_ value: String) -> Bool {
        value.isValidEmail
    }
    
    private func evaluatePassword(_ value: String) -> Bool {
        value.isValidComplexPassword
    }
    
    private func evaluateForm(_ userNameValid: Published<Bool>.Publisher.Output, _ passwordValid: Published<Bool>.Publisher.Output) -> Bool {
        userNameValid && passwordValid
    }
    
    func login() {
        service.login()
    }
}
