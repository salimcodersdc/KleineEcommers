//
//  RegisterScreen.swift
//  KleineEcommers
//
//  Created by Yousef on 11/9/21.
//

import SwiftUI
import Combine

protocol RegisterViewModelServiceProtocol {
    func register()
}

class RegisterViewModelService: RegisterViewModelServiceProtocol {
    func register() {
        AuthManager.shared.register()
    }
    
}

class RegisterViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    
    @Published var isFirstNameValid: Bool = false
    @Published var isPasswordValid:  Bool = false
    @Published var isEmailValid:     Bool = false
    @Published var isPhoneValid:     Bool = false
    @Published var isValid: Bool = false
    
    private var service: RegisterViewModelServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: RegisterViewModelServiceProtocol) {
        self.service = service
        
        AddSubcripers()
    }
    
    func register() {
        service.register()
    }
    
    private func AddSubcripers() {
        $firstName
            .map(evaluateFirstName)
            .sink { [unowned self] valid in
                isFirstNameValid = valid
            }
            .store(in: &cancellables)
        
        $password
            .map(evaluatePassword)
            .sink { [unowned self] valid in
                isPasswordValid = valid
            }
            .store(in: &cancellables)
        
        $email
            .map(evaluateEmail)
            .sink { [unowned self] valid in
                isEmailValid = valid
            }
            .store(in: &cancellables)
        
        $phone
            .map(evaluatePhone)
            .sink { [unowned self] valid in
                isPhoneValid = valid
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($isFirstNameValid, $isPasswordValid, $isEmailValid, $isPhoneValid)
            .map(evaluateForm)
            .sink { [unowned self] valid in
                isValid = valid
            }
            .store(in: &cancellables)
    }
    
    //MARK:- Validation Stuff
    private func evaluateFirstName(_ value: String) -> Bool {
        value.count > 5 && Validator.userName.predicate.evaluate(with: value)
    }
    
    private func evaluatePassword(_ value: String) -> Bool {
        Validator.password.predicate.evaluate(with: value)
    }
    
    private func evaluateEmail(_ value: String) -> Bool {
        Validator.email.predicate.evaluate(with: value)
    }
    
    private func evaluatePhone(_ value: String) -> Bool {
        Validator.phone.predicate.evaluate(with: value)
    }
    
    private func evaluateForm(
        firstNameValid: Published<Bool>.Publisher.Output,
        passwordValid: Published<Bool>.Publisher.Output,
        emailValid: Published<Bool>.Publisher.Output,
        phoneValid: Published<Bool>.Publisher.Output) -> Bool {
        firstNameValid && passwordValid && emailValid && phoneValid
    }
    
}
struct RegisterScreen: View {
    
    @Binding var page: UnAuthController.Page
    @StateObject var viewModel: RegisterViewModel
    
    init(page: Binding<UnAuthController.Page>,
         service: RegisterViewModelServiceProtocol = RegisterViewModelService()) {
        self._page = page
        self._viewModel = StateObject(wrappedValue: RegisterViewModel(service: service))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.theme.mainBackground
            
            PartialMobileBackground(showLogo: false,
                                    darkColor: Color.fromHexString("#B0B6FF"),
                                    lightColor: Color.fromHexString("#F5F8FA"))
            
            gradientLayer
            
            content
        }
    }
}

extension RegisterScreen {
    private var gradientLayer: some View {
        
        LinearGradient(
            gradient: Gradient(colors: [
                Color.fromHexString("000DAE").opacity(0.8),
                Color.fromHexString("849DFE").opacity(0.8),
                Color.fromHexString("849DFE").opacity(0.8),
                Color.white,
                Color.white
            ]),
            startPoint: .top,
            endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            
            Spacer()
                .frame(height: 80)
            
            header
            
            textFields
            
            loginButton
            
            socialLoginButtons
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            LogoView()
            
            Text("Let's Register.")
                .font(Font.fontBook.bold(34))
                .foregroundColor(Color.white)
            
            Button(action: {
                page = .login
            }, label: {
                Text("Don't you have an account? Login")
                    .font(Font.fontBook.regular(12))
                    .foregroundColor(Color.white)
                    .padding(.top)
            })
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var textFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("your name", text: $viewModel.firstName)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isFirstNameValid ? Color.white : Color.red)
            
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isPasswordValid ? Color.white : Color.red)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isEmailValid ? Color.white : Color.red)
            
            TextField("Phone", text: $viewModel.phone)
                .textFieldStyle(KleineTextFieldStyle())
                .border(viewModel.isPhoneValid ? Color.white : Color.red)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 32)
    }
    
    private var loginButton: some View {
        Button(action: {
            viewModel.register()
        }, label: {
            Text("Register")
                .font(Font.fontBook.semiBold())
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color.theme.primary)
                        .cornerRadius(8)
                )
        })
        .padding(.top, 32)
//        .disabled(!viewModel.isValid)
        .opacity(viewModel.isValid ? 1 : 0.6)
    }
    
    private var socialLoginButtons: some View {
        HStack {
            Button(action: {}, label: {
                KleineSocialLogin(label: "FaceBook") {
                    Image("facebook")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                        .padding(.leading, 8)
                        .padding(.top, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.theme.secondary)
                    )
                }
            })
            
            Spacer()
            
            Button(action: {}, label: {
                KleineSocialLogin(label: "Google") {
                    Image("google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                }
            })
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen(page: .constant(.register))
    }
}
